
test:
	flutter test

analyze:
	flutter analyze

build-linux:
	flutter build linux --release

run:
	flutter run lib/main.dart

install:
	cp -R build/linux/x64/release/bundle /opt/KafkaTool
	cp kafka_tool.desktop /usr/share/applications/

bundle-linux:
	cd build/linux/x64/release/bundle && tar -czvf kafka_tool_linux.tar.gz data lib kafka_tool
