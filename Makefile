generate:
	dart run build_runner build --delete-conflicting-outputs

buildRunner:
	flutter packages pub run build_runner build --delete-conflicting-outputs

upgrade:
	flutter pub upgrade