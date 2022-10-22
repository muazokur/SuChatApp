class GetProfileUrl {
  static String getProfileUrl(String url) {
    String userDefault =
        "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-photo-183042379.jpg";
    if (url == "Fotoğraf Yok") {
      return userDefault;
    } else {
      return url;
    }
  }
}
