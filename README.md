# kafka_tool

## Install flutter
- Download and extract flutter
```
curl -L https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.2-stable.tar.xz | sudo tar -xJ -C /usr/bin
```
- Add Flutter to the PATH
```
echo 'export PATH="/usr/bin/flutter/bin:$PATH"' >> ~/.profile
```

## Development tools
To develop Flutter on Linux 
``` sh
sudo apt install clang cmake git ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev
```

## Run project
``` 
make run
```

## Release
- Bundle project
```
flutter build linux --release
```
- Copy bundle to /opt
``` 
sudo cp -R build/linux/x64/release/bundle /opt/KafkaTool
```
- Install the desktop entry file (it will installed into folder /usr/share/applications)
```
sudo desktop-file-install ./kafka_tool.desktop
```
- Update desktop database
```
sudo update-desktop-database
```
