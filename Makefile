
test:
	flutter test

analyze:
	flutter analyze

run:
	flutter run lib/main.dart

release:
	flutter build linux --release

build-linux:
	flutter build linux --release

bundle-linux:
	cd build/linux/x64/release/bundle && tar -czvf kafka_tool_linux.tar.gz data lib kafka_tool
