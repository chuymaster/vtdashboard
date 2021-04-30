### Automate setup, referred to https://qiita.com/uhooi/items/7b14b5ce413989c751c3 for more detail

# Variables

PRODUCT_NAME := VtDashboard
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace

.PHONY: setup
setup: # Install dependencies and prepared development configuration
	$(MAKE) install-mint
	$(MAKE) install-cocoapods
	$(MAKE) update-cocoapods
	$(MAKE) generate-licenses
	$(MAKE) xcodegen
	$(MAKE) open

.PHONY: install-mint
install-mint: # Install Mint dependencies
	mint bootstrap --overwrite y

.PHONY: xcodegen
xcodegen: # # Generate project with XcodeGen
	mint run xcodegen --use-cache

.PHONY: install-cocoapods
install-cocoapods: # Install CocoaPods dependencies and generate workspace
	bundle exec pod install

.PHONY: update-cocoapods
update-cocoapods: # Update CocoaPods dependencies and generate workspace
	bundle exec pod update

.PHONY: generate-licenses
generate-licenses: # Generate licenses with LicensePlist
	mint run LicensePlist license-plist --output-path ${PRODUCT_NAME}/Settings.bundle --add-version-numbers

.PHONY: open
open: # Open workspace in Xcode
	open ./${WORKSPACE_NAME}

.PHONY: clean
clean: # Delete cache
	rm -rf ./Pods
	rm -rf ./Carthage
	rm -rf ./vendor/bundle
	rm -rf ./Templates
	sudo xcodebuild clean -alltargets

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-42s%s\n", $$1 $$3, $$2}'

.PHONY: generate-licenses
generate-licenses: # Generate licenses with LicensePlist
	mint run LicensePlist license-plist --output-path ${PRODUCT_NAME}/Settings.bundle --add-version-numbers