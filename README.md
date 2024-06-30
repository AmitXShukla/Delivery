# Delivery Management App
A free download to build a complete Truck/Services/delivery ride app in Flutter and Parse Framework (Back4app/MongoDB)

`upgraded to DART 3.4 & Flutter 3.22`

## Connect

[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/youtube.svg" width=40 height=50>](https://youtube.com/@Amit.Shukla)
[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/github.svg" width=40 height=50>](https://github.com/AmitXShukla)
[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/medium.svg" width=40 height=50>](https://medium.com/@Amit-Shukla)
[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/twitter_1.svg" width=40 height=50>](https://twitter.com/ashuklax)


## [Video Tutorials](https://www.youtube.com/playlist?list=PLp0TENYyY8lF4iUFdA5SRyNacw_w2mp2w)

[Demo Page](https://amitxshukla.github.io/Delivery/)

![App Image](./images/app_image.png)

![Pro UI](./images/pro_ui.png)

## Installation
![App Image](./images/app_image_2.png)

> Sign up at back4app.com and copy your keys into main.dart

```mermaid
stateDiagram-v2
        direction LRstateDiagram-v2
        [*] --> signup
        signup --> email
        signup --> social
        email --> login
        social --> login
        login --> Settings
        dark_Mode --> Settings
        multi_Lang --> Settings
        reset_Password --> Settings
        update_PhoneAddressEmail --> Settings
        login --> Provider
        login --> Rider
        Rider --> Book
        Book --> Bid
        Offer --> Bid
        Bid --> Messages
        Settings --> Messages
        Messages --> Settings
        Provider --> Offer
        Settings --> [*]
        
%% Define classes for coloring
    classDef red fill:#ff8,stroke:#333,stroke-width:2px;
    classDef green fill:#8fa,stroke:#333,stroke-width:2px;
    classDef blue fill:#8af,stroke:#333,stroke-width:2px;
    classDef orange fill:#f92,stroke:#333,stroke-width:2px;
    classDef yellow fill:#56f,stroke:#333,stroke-width:2px;
    classDef brown fill:#fe3,stroke:#333,stroke-width:2px;
    classDef neil fill:#1ff,stroke:#333,stroke-width:2px;

    %% Apply classes to states
    class signup green
    class email green
    class social green
    class login blue
    class Rider orange
    class Book orange
    class Rider orange
    class Provider orange
    class Offer orange
    class Bid brown
    class dark_Mode neil
    class multi_Lang neil
    class reset_Password neil
    class update_PhoneAddressEmail neil
    class Settings brown
    class Messages green
    
```

## Features
- Flutter, Parse Framework back-end (Back4App / MongoDB)
- Multilingual
- Dark and Light Theme
- Driver and Customer
- Bid based interface
- Image/File uploads
- Role based Architecture
- App Message / Notification feature
- email login verification

## Pro Features
- search nearby drivers
- discounted rides
- food, service and other deliveries
- Advertise with us
- live maps
- live push notifications
- blue badge drivers
- advance cloud code functions based security

## License Agreement

[License Information](https://github.com/AmitXShukla/Delivery/blob/main/License)

## Privacy Policy

[Privacy Policy](https://github.com/AmitXShukla/Delivery/blob/main/License)
