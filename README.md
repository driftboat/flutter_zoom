# flutter_zoom

# example
- git clone 
- git lfs pull
- Create SDK App JWT Token
  - https://marketplace.zoom.us/docs/sdk/native-sdks/android/mastering-zoom-sdk/sdk-initialization => Composing JWT for SDK Initialization
  - Generate JWT Token from https://jwt.io/ for testing. 
  
    Get from your server for distribution. 
    
    You can get current timestamp from https://www.unixtimestamp.com/. 
    
    Enter your "SDK App Secret" in "your-256-bit-secret",Get  token from the left. 
    
    ```
    {
      "appKey": "string", // Your SDK key
      "iat": long, // access token issue timestamp
      "exp": long, // access token expire timestamp, iat + a time less than 48 hours
      "tokenExp": long // token expire time, MIN:1800 seconds
    }
    ```
    Example：  
    ```
    {
      "appKey": "xxxxxxxxxxxxxxxxxxxx", 
      "iat": 1615510799, 
      "exp": 1647017999, 
      "tokenExp": 1647017999 
    }
    ```
-  replace "your jwtToken" in "zoom/example/lib/join_screen.dart"

# Reference
https://github.com/decodedhealth/flutter_zoom_plugin