import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_experience/Insta/post_desc.dart';
import 'heart_icon_animator.dart';
import 'heart_overlay_animator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'models.dart';
import 'avatar_widget.dart';
import 'comment_widget.dart';
import 'ui_utils.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  PostWidget(this.post);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final StreamController<void> _doubleTapImageEvents =
      StreamController.broadcast();
  bool _isSaved = false;
  int _currentImageIndex = 0;

  @override
  void dispose() {
    _doubleTapImageEvents.close();
    super.dispose();
  }

  void _updateImageIndex(int index, CarouselPageChangedReason reason) {
    setState(() => _currentImageIndex = index);
  }

  void _onDoubleTapLikePhoto() {
    setState(() => widget.post.addLikeIfUnlikedFor(currentUser));
    _doubleTapImageEvents.sink.add(null);
  }

  void _toggleIsLiked() {
    setState(() => widget.post.toggleLikeFor(currentUser));
  }

  void _toggleIsSaved() {
    setState(() => _isSaved = !_isSaved);
  }

  void _showAddCommentModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddCommentModal(
            user: currentUser,
            onPost: (String text) {
              setState(() {
                widget.post.comments.add(Comment(
                  text: text,
                  user: currentUser,
                  commentedAt: DateTime.now(),
                  likes: [],
                ));
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white ),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: EdgeInsets.only(top: 20,bottom: 10),

      child: Column(
        
        children: <Widget>[

          Container(
            height: 40,
            child: Stack(
              overflow: Overflow.visible,
              
              children: [
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  top: -25.0,
                  right: 133.0,
                  child: AvatarWidget(user: widget.post.user),
                ),

                Positioned(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  top: 0,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 77,top: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.post.user.name, style: bold),
                              Container(height: 2),

                              if (widget.post.location != null)
                                Text(widget.post.location,style: TextStyle(color: Colors.grey,fontSize: 11),),
                              
                              // Text(
                              //   widget.post.timeAgo(),
                              //   style: TextStyle(color: Colors.grey, fontSize: 11.0),
                              // ),
                            ],
                          ),
                        ),
                      
                        Spacer(),
                        
                        IconButton(   
                          padding: const EdgeInsets.only(bottom: 10),
                          icon: Icon(Icons.more_vert),
                          onPressed: () => showSnackbar(context, 'More'),
                        )
                          
                      ],
                    ),
                  ),
                ),
              ]
            )
          ),

          

          if (widget.post.comments.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: widget.post.comments
                          .map((Comment c) => PostDescWidget(c))
                          .toList(),
                    ),
                  ),


          // Photo Carosuel
          GestureDetector(
            
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CarouselSlider(
                    items: widget.post.imageUrls.map((url) {


                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            url,
                            fit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.width,
                          )
                        )
                      );

                    }).toList(),
                    options: CarouselOptions(
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    onPageChanged: _updateImageIndex,
                    )
                  ),
                  HeartOverlayAnimator(
                      triggerAnimationStream: _doubleTapImageEvents.stream),
                ],
            
            ),
            onDoubleTap: _onDoubleTapLikePhoto,
          ),


          // Action Bar
          Container(
            height: 30,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.only(left: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Container(
                  width: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: HeartIconAnimator(
                    isLiked: widget.post.isLikedBy(currentUser),
                    size: 28.0,
                    onTap: _toggleIsLiked,
                    triggerAnimationStream: _doubleTapImageEvents.stream,
                  ),
                ),

                Container(
                  width: 35,
                  child: Text('${widget.post.likes.length}',
                      style: bold),
                    

                    // Text(widget.post.likes[0].user.name, style: bold),
                    // if (widget.post.likes.length > 1) ...[
                    //   Text(' and'),
                    //   Text(' ${widget.post.likes.length - 1} others',
                    //       style: bold),
                    // ]
                ),

                Container(
                  width: 30,
                  child: IconButton(
                    padding: EdgeInsets.only(right: 10),
                    iconSize: 28.0,
                    icon: Icon(Icons.chat_bubble_outline),
                    onPressed: _showAddCommentModal,
                  ),
                ),

                Container(
                  width: 20,
                  child: Text(
                    widget.post.comments.length.toString(),
                    style: bold)
                  ),
              
                Spacer(),

                if (widget.post.imageUrls.length > 1)
                  PhotoCarouselIndicator(
                    photoCount: widget.post.imageUrls.length,
                    activePhotoIndex: _currentImageIndex,
                  ),
                  
                Spacer(), 
                Spacer(),
                Spacer(),

                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 28.0,
                  icon:
                      _isSaved ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border),
                  onPressed: _toggleIsSaved,
                )
              ],
            ),
          ),


          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                // Comments
                if (widget.post.comments.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), 
                      border: Border.all(
                        color: Colors.grey[300],
                        width: 1.0
                      )
                    ),
                    padding: const EdgeInsets.only(top:5, bottom: 5.0,left: 16, right: 0),
                    child: Column(
                      children: widget.post.comments
                          .map((Comment c) => CommentWidget(c))
                          .toList(),
                    ),
                  ),
              
              ],
            ),
          ),
        ],
      )
    );
  }
}

class PhotoCarouselIndicator extends StatelessWidget {
  final int photoCount;
  final int activePhotoIndex;

  PhotoCarouselIndicator({
    @required this.photoCount,
    @required this.activePhotoIndex,
  });

  Widget _buildDot({bool isActive}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: isActive ? 7.5 : 6.0,
          width: isActive ? 7.5 : 6.0,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(photoCount, (i) => i)
          .map((i) => _buildDot(isActive: i == activePhotoIndex))
          .toList(),
    );
  }
}

class AddCommentModal extends StatefulWidget {
  final User user;
  final ValueChanged<String> onPost;

  AddCommentModal({@required this.user, @required this.onPost});

  @override
  _AddCommentModalState createState() => _AddCommentModalState();
}

class _AddCommentModalState extends State<AddCommentModal> {
  final _textController = TextEditingController();
  bool _canPost = false;

  @override
  void initState() {
    _textController.addListener(() {
      setState(() => _canPost = _textController.text.isNotEmpty);
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AvatarWidget(user: widget.user),
        Expanded(
          child: TextField(
            controller: _textController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Add a comment...',
              border: InputBorder.none,
            ),
          ),
        ),
        FlatButton(
          child: Opacity(
            opacity: _canPost ? 1.0 : 0.4,
            child: Text('Post', style: TextStyle(color: Colors.blue)),
          ),
          onPressed:
              _canPost ? () => widget.onPost(_textController.text) : null,
        )
      ],
    );
  }
}
