#
#  The SwiftLint recipes require the Swift Package Resources scripts to be installed.
#
#  https://github.com/TinderApp/Swift-Package-Resources#installation
#

.PHONY: open
open: fix
open:
	xed Package.swift

.PHONY: fix
fix: XCSHAREDDATA = .swiftpm/xcode/package.xcworkspace/xcshareddata
fix:
	@mkdir -p $(XCSHAREDDATA)
	@/usr/libexec/PlistBuddy -c \
		"Delete :FILEHEADER" \
		"$(XCSHAREDDATA)/IDETemplateMacros.plist" >/dev/null 2>&1 || true
	@header=$$'\n//  Copyright © ___YEAR___ Tinder \(Match Group, LLC\)\n//'; \
	/usr/libexec/PlistBuddy -c \
		"Add :FILEHEADER string $$header" \
		"$(XCSHAREDDATA)/IDETemplateMacros.plist" >/dev/null 2>&1

.PHONY: lint
lint: format ?= emoji
lint:
	@swiftlint lint --strict --progress --reporter "$(format)"

.PHONY: analyze
analyze: target ?= CombineUI
analyze: destination ?= generic/platform=macOS
analyze: format ?= emoji
analyze:
	@DERIVED_DATA="$$(mktemp -d)"; \
	XCODEBUILD_LOG="$$DERIVED_DATA/xcodebuild.log"; \
	xcodebuild \
		-scheme "$(target)" \
		-destination "$(destination)" \
		-derivedDataPath "$$DERIVED_DATA" \
		-configuration "Debug" \
		CODE_SIGNING_ALLOWED="NO" \
		> "$$XCODEBUILD_LOG"; \
	swiftlint analyze --strict --progress --reporter "$(format)" --compiler-log-path "$$XCODEBUILD_LOG"

.PHONY: rules
rules:
	@swiftlint rules | lint-rules

.PHONY: delete-snapshots
delete-snapshots:
	@for snapshots in $$(find Tests -type d -name "__Snapshots__"); \
	do \
		rm -rf "$$snapshots"; \
		echo "Deleted $$snapshots"; \
	done
