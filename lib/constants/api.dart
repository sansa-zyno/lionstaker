class Api {
  static String get baseUrl {
    return "https://lionstaker.com/appdata";
  }

  static const login = "/login.php";
  static const register = "/signup.php";
  static const feeds = "/feeds.php";
  static const whoToFollow = "/whotofollow.php";
  static const addTips = "/addtips.php";
  static const forgotPassword = "/forgotpassword.php";
  static const getEmail = "/getemail.php";
  static const changePassword = "/changepassword.php";
  static const resetRead = "/chatread.php";
  static const changeProfilePics = "/changeprofilepics.php";
  static const chat = "/chatscreen.php";
  static const addImage = "/sendfile.php";
  static const addMessage = "/sendchatmessage.php";
  static const forum = "/forum.php";
  static const addImageToGroup = "/sendfiletogroup.php";
  static const addMessageToGroup = "/sendforummessage.php";
  static const recentChats = "/recentchats.php";
  static const admins = "/admins.php";
  static const getProfilePics = "/getprofilepics.php";
  static const getProfileDetails = "/loadprofile.php";
  static const editProfile = "/editprofile.php";
  static const support = "/supportscreen.php";
  static const latestNews = "/latestnews.php";
  static const pointHistory = "/pointhistory.php";
  static const notifications = "/notification.php";
  static const getPostComments = "/postcomments.php";
  static const profile = "/profilescreen.php";
  static const addComments = "/addcomment.php";
  static const addLikes = "/addlike.php";
  static const addUnLikes = "/addunlike.php";
  static const betWin = "/betcodewin.php";
  static const betNotWin = "/betcodenotwin.php";
  static const betIsSpam = "/betisspam.php";
  static const betIsNotSpam = "/betisnotspam.php";
  static const follow = "/follow.php";
  static const commentedPosts = "/commentedposts.php";
  static const likedOrDislikedPosts = "/likedposts.php";
  static const posts = "/posts.php";
  static const sharePost = "/sharepoint.php";
  static const unfollow = "/unfollow.php";
  static const betlogo = "/betlogo.php";
  static const unReadNotification = "/unreadnotification.php";
  static const updateNotification = "/updatenotification.php";

  // Other pages

  static String get inappSupport {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/support/chat";
  }
}
