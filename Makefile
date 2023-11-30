test:
	flutter test

analyze:
	flutter analyze

run:
	flutter run lib/main.dart

release:
	flutter build linux --release

bundle:
	tar -cf bundle.tar build/linux/x64/release/bundle

clean:
	rm bundle.tar
