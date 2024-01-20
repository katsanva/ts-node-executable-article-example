:: Build the otput bundle
npm run build
:: Generate the blob to be injected
node --experimental-sea-config sea-config.json
:: Create a copy of the node executable
node -e "require('fs').copyFileSync(process.execPath, 'dist/win.exe')" 
:: Remove the signature of the binary
signtool remove /s dist/win.exe
:: Inject the blob into the copied binary by running postject
npx postject dist/win.exe NODE_SEA_BLOB dist/out.blob `
    --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2 
:: Sign the binary
signtool sign /fd SHA256 dist/win.exe
