#!/bin/bash
# Build the otput bundle
npm run build
# Generate the blob to be injected
node --experimental-sea-config sea-config.json
# Create a copy of the node executable
cp $(command -v node) dist/macos
# Remove the signature of the binary
codesign --remove-signature dist/macos
# Inject the blob into the copied binary by running postject
npx -y postject dist/macos NODE_SEA_BLOB dist/out.blob \
--sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2 \
--macho-segment-name NODE_SEA
# Sign the binary
codesign --sign - dist/macos
# Make the binary executable
chmod +x dist/macos
