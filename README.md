# kafka_tool

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
