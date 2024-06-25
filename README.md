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
- Copy desktop entry file 

```
cp kafka_tool.desktop ~/.local/share/applications/
```
