/// Get your own App ID at https://dashboard.agora.io/
String get appId {
  // Allow pass an `appId` as an environment variable with name `TEST_APP_ID` by using --dart-define
  return const String.fromEnvironment('a3a204d0d40f4924a83e0b6f75db1f5b',//your app id from agora
      defaultValue: 'a3a204d0d40f4924a83e0b6f75db1f5b'//your app id from agora
  );
}

/// Please refer to https://docs.agora.io/en/Agora%20Platform/token
String get token {
  // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
  return const String.fromEnvironment('007eJxTYDifLnGieXuA2a7F0+8srot7IxOmdqt15QyHPat5JicbnLmmwJBonGhkYJJikGJikGZiaWSSaGGcapBklmZumpJkmGaaNN/0SEpDICNDjX4RAyMUgvisDEX5mZkpDAwAyIQgwQ==',
      defaultValue: '007eJxTYDifLnGieXuA2a7F0+8srot7IxOmdqt15QyHPat5JicbnLmmwJBonGhkYJJikGJikGZiaWSSaGGcapBklmZumpJkmGaaNN/0SEpDICNDjX4RAyMUgvisDEX5mZkpDAwAyIQgwQ==');
}

/// Your channel ID
String get channelId {
  // Allow pass a `channelId` as an environment variable with name `TEST_CHANNEL_ID` by using --dart-define
  return const String.fromEnvironment(
    'roiid',
    defaultValue: 'roiid',
  );
}

/// Your int user ID
const int uid = 0;

/// Your user ID for the screen sharing
const int screenSharingUid = 10;

/// Your string user ID
const String stringUid = '0';

String get musicCenterAppId {
  // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
  return const String.fromEnvironment('MUSIC_CENTER_APPID',
      defaultValue: '<MUSIC_CENTER_APPID>');
}