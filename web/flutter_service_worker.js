'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"afronalalogo.png": "29b6c4831c24b290a3f707b762fa6574",
"assets/afronalalogo.png": "29b6c4831c24b290a3f707b762fa6574",
"assets/AssetManifest.bin": "574b701c3702d06a5cba66952fa947cc",
"assets/AssetManifest.bin.json": "bf3f23fc15035fe543e6729899575b4b",
"assets/AssetManifest.json": "e8afbc08e78b7de475f6f6c578ad436c",
"assets/assets/afronalalogo.png": "29b6c4831c24b290a3f707b762fa6574",
"assets/assets/favicon.png": "8f2f8788ef173e69858fd8329a0b0a10",
"assets/favicon.png": "8f2f8788ef173e69858fd8329a0b0a10",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "2c4aac766baf55a768a79f209b2ba155",
"assets/NOTICES": "39cb5b95ff8a7cfa1bedfb461d95ed21",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "8f2f8788ef173e69858fd8329a0b0a10",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "9cfd07ad42843b9499c99a403db170d3",
"/": "9cfd07ad42843b9499c99a403db170d3",
"main.dart.js": "45da3d96a647671ccf050ffc0a6cc7a2",
"manifest.json": "572bcdb5a23ed2b0687887745430ae0d",
"TruckRide/.git/COMMIT_EDITMSG": "57c3be43225cfdfb9a01a340e7a9732c",
"TruckRide/.git/config": "4fbc6a7ceff49aab167b241b30ee1709",
"TruckRide/.git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
"TruckRide/.git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
"TruckRide/.git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
"TruckRide/.git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
"TruckRide/.git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
"TruckRide/.git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
"TruckRide/.git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
"TruckRide/.git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
"TruckRide/.git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
"TruckRide/.git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
"TruckRide/.git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
"TruckRide/.git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
"TruckRide/.git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
"TruckRide/.git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
"TruckRide/.git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
"TruckRide/.git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
"TruckRide/.git/index": "1745cc930baa288bc36e7862c84ec8ef",
"TruckRide/.git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
"TruckRide/.git/logs/HEAD": "6eeca67620c50df76231fe1a2573f298",
"TruckRide/.git/logs/refs/heads/gh-pages": "22364b60652751ec03ce39593b739de5",
"TruckRide/.git/logs/refs/remotes/origin/gh-pages": "fd73f658ce35d6aa65d6819818a53702",
"TruckRide/.git/logs/refs/remotes/origin/HEAD": "f505118d12f2e8c7b3efe9d7d93f7cd6",
"TruckRide/.git/objects/00/f97957b36ea12af0dad1d688cba93f0a8228c9": "ab6b786cbb96c116906d984cb1a194e0",
"TruckRide/.git/objects/06/50c273b951becbd747cd93b8900720f7d13932": "7d0c08395ac1d355ae32d1c864bf4cef",
"TruckRide/.git/objects/07/74c17c0fa7a7e87e24a6935830998d92b52c75": "cd62ee54b7ceea7b2a7804e69b1d9134",
"TruckRide/.git/objects/0a/36119cddbec54945a096a89505cfe3b4c88dec": "e2cbd53e8e44966e1385d1d0241e6282",
"TruckRide/.git/objects/0c/b1b13df4198eb737d53d594387a30bce73259e": "2df815d0748e26e14e935ce8c3782883",
"TruckRide/.git/objects/0d/1c871442b057827ed800d44e21e7aafa5ad63b": "4962408bda47b3f31eb652c589d65a88",
"TruckRide/.git/objects/16/5ce0ddf03a820a38f48cba9aa0c9df9b6e6b79": "71df17c95c3124eada62b59e7dabda78",
"TruckRide/.git/objects/16/9f1f0e4e8fc82393e01c49b0169785c9c07dbd": "b0424a735ab6af7060ae158f01a778d0",
"TruckRide/.git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
"TruckRide/.git/objects/21/fdb9289d39d32f8b2977bce3359e41e7a05cf4": "cf269b055d6711c9ee6e5dac15998f5a",
"TruckRide/.git/objects/27/09964abd55d8558d1ec65f7ff52fc4b8740cea": "2fd32618584b90e14d6dc92458f7aa8b",
"TruckRide/.git/objects/32/baf71b1c927020781fd1a78f7e0bedb495609b": "4664276149817738c2ba3e034d2f60d9",
"TruckRide/.git/objects/34/3a56805f8c3b34df4b88bb1a30dcd9e48a0b05": "6aec783224339840c871701c14e6b1aa",
"TruckRide/.git/objects/3c/a3dfcfb6cbfe5b88e9ca01ac86e2e4aade0890": "58e83186f590723e59816f8314075919",
"TruckRide/.git/objects/42/56604405ed541d0d5e2ff15c272e1243c7e368": "aa9e777be9231a0f2609787af9454c15",
"TruckRide/.git/objects/42/baf0bcd4a1bcc5066766b001194c210cf72b4f": "2955c45620a5f4903a6c171797b41c8a",
"TruckRide/.git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
"TruckRide/.git/objects/48/463cac48c7cdb9bd76b13854999f51371687c8": "c529347ec9d648f8d60efb523846060c",
"TruckRide/.git/objects/4a/39079e580dc9be820cba2fae41238c49eaa798": "ada1a19fea32fbb6719120809b9eae60",
"TruckRide/.git/objects/53/7807567919e88db2866b7825339c57e94c24d8": "970aec5149a3dbe9370a9dc982cdd022",
"TruckRide/.git/objects/59/6555971faddb988e02f90562ccf3dac3bc28ff": "da38c30fcf00cf1b2755d9fccf5507af",
"TruckRide/.git/objects/5a/7b05e1be311772247124911182fda78fde2cec": "d38bfbb93663df272dc4920186bd1040",
"TruckRide/.git/objects/65/e39d144ca164327ce54942927eaafa2cb7cc75": "76587549d99aabf29bdc878fe95b84ad",
"TruckRide/.git/objects/69/1f15e87bca77ac1c5f9f25f3a5bfb6011eac1f": "2b73ee238e0959fb73c71168b49792e2",
"TruckRide/.git/objects/6f/9cad4c116bc8d72e2497226abb5c05ee64982c": "0d104480d68c1652a53721377a02a882",
"TruckRide/.git/objects/71/7117947090611c3967f8681ab1ac0f79bca7fc": "ad4e74c0da46020e04043b5cf7f91098",
"TruckRide/.git/objects/71/7809363ed19bdd7e1d78f6e421e40a96bc29e3": "9414a3044cb191cc3f57340f57c3dc93",
"TruckRide/.git/objects/93/247db294b723d0c699ab05d378bd57ea98de50": "5f742beebda6c2b89f033685c3588c3c",
"TruckRide/.git/objects/94/bfb1463ad8331bfd687bc751b8920b133da744": "fd2d8c0d844b234856b36b93f652048f",
"TruckRide/.git/objects/95/239046be9aea9924a1332940507e5b967deb7b": "fb8e20d6acf5613f03494ad7a97d5476",
"TruckRide/.git/objects/95/7cc9a1f5f476ce0782c764acfb310ccc94a28c": "51506470fdca75c0667c598c15e91358",
"TruckRide/.git/objects/98/87a8ae9dbd0e8143164cb02ff6f3717c62410b": "2429e45f8f58883022e8c20f95274899",
"TruckRide/.git/objects/a7/8937a860259a2a52fd108d90c385618e8cd759": "8983197139f7d925f7136b55a0b63544",
"TruckRide/.git/objects/a9/c2b87ea4a602ed310b524dff6dbd679cb296af": "ed819f9b08b6c50d8f0d1ed596971536",
"TruckRide/.git/objects/af/742adee0a85dd21ea96cbd84182e30e085d6cf": "aa25b932ec40efacb1efe27e7cf25d82",
"TruckRide/.git/objects/b3/6710eb724311fb8e3af74be743c2d7dafd5d12": "249cc4971421807b645d302554941b91",
"TruckRide/.git/objects/b4/9a6156814f97f76cec9fcd4f148f8ae931758b": "45b923d25a448fdbbabd714a885bbfcf",
"TruckRide/.git/objects/b5/0254288cc6319d153c4af1d64870d95ee2436f": "468a6506934a07c970a4739eae75eedd",
"TruckRide/.git/objects/c5/f4bc2a4da91586f3005813077f0d0aa9040f82": "3191028b787554cee4652f5050144bff",
"TruckRide/.git/objects/c7/1f628da53c94b1130f839a69b92e4b5ba3cb0d": "2b3a17e388e7ba3e0c9aaf4561050a92",
"TruckRide/.git/objects/cd/971c778b19b74af889f717a792aae1c2d8d6af": "436179c7801b5788a8eed6e44d98348f",
"TruckRide/.git/objects/cf/a66c426e56c52cb4f8998b7646030067ec9a77": "a8dabee30e97c2952408a22d6d0e93a1",
"TruckRide/.git/objects/d1/788837f4604a1d96aff93aa0de199f12169e44": "f7c934c2b497dd3680d5ed5a0eec8ab7",
"TruckRide/.git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
"TruckRide/.git/objects/d7/2c11112c7cb4e2ce754bc41470f9b829a2d00a": "d7280a766a5d6033f187d874a92b5ad6",
"TruckRide/.git/objects/d7/e51b753153d8061bc8bfbf32924a8f3270fb41": "d0fc1c585e221ed7a93a542aee360891",
"TruckRide/.git/objects/df/7d2dcb89ab89da87467c0e1059b38c8d8f9296": "a44162ff357b024e4638ab18a9bb01c7",
"TruckRide/.git/objects/df/c4c183982361456b4ea455f1f0c2b5e7e7f9da": "25719d64733e61a196aaea9cee51b5cb",
"TruckRide/.git/objects/e4/23b78f209311de2e17aca1323ae2096301dce8": "2874656a1c374be896b5faaa9f3847bd",
"TruckRide/.git/objects/e6/b745f90f2a4d1ee873fc396496c110db8ff0f3": "2933b2b2ca80c66b96cf80cd73d4cd16",
"TruckRide/.git/objects/e6/fe5008ac5a795736cf9b3c6baa888a564f04e4": "bb147d6c24338ecef47eb9827d09ce2c",
"TruckRide/.git/objects/e8/2c5850db3a3482d0c954a4dc122c02de555ce7": "d357cd906b3805bf81477f5527cca086",
"TruckRide/.git/objects/ee/9dbac97849182e1dbc7fa5049f9e834d9b54f7": "b6aa0cd0a1b7d98ff8daade739c140f5",
"TruckRide/.git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
"TruckRide/.git/objects/fd/1663170313449db9254f0364a0a7045a3cc22d": "4b06919446be4f3263ddb7edaec99889",
"TruckRide/.git/objects/pack/pack-87b56e613a1e34f943b3cc323966dc43f86b9a5c.idx": "37ece053d6ef69fc5f81df3f2f599831",
"TruckRide/.git/objects/pack/pack-87b56e613a1e34f943b3cc323966dc43f86b9a5c.pack": "0076003d7d9fb89636bc7520f68091f5",
"TruckRide/.git/objects/pack/pack-87b56e613a1e34f943b3cc323966dc43f86b9a5c.rev": "fff9013bfcad55e5162826a223e22ef7",
"TruckRide/.git/packed-refs": "466d4024d295bcb4fbb67ece4ff87047",
"TruckRide/.git/refs/heads/gh-pages": "c8565812f9f0e517c1d644b8d67d08e3",
"TruckRide/.git/refs/remotes/origin/gh-pages": "c8565812f9f0e517c1d644b8d67d08e3",
"TruckRide/.git/refs/remotes/origin/HEAD": "98b16e0b650190870f1b40bc8f4aec4e",
"TruckRide/Dockerfile": "e779117aba882cc3a3ea030a85e6700d",
"TruckRide/web/afronalalogo.png": "29b6c4831c24b290a3f707b762fa6574",
"TruckRide/web/assets/afronalalogo.png": "29b6c4831c24b290a3f707b762fa6574",
"TruckRide/web/assets/AssetManifest.bin": "574b701c3702d06a5cba66952fa947cc",
"TruckRide/web/assets/AssetManifest.bin.json": "bf3f23fc15035fe543e6729899575b4b",
"TruckRide/web/assets/AssetManifest.json": "e8afbc08e78b7de475f6f6c578ad436c",
"TruckRide/web/assets/assets/afronalalogo.png": "29b6c4831c24b290a3f707b762fa6574",
"TruckRide/web/assets/assets/favicon.png": "8f2f8788ef173e69858fd8329a0b0a10",
"TruckRide/web/assets/favicon.png": "8f2f8788ef173e69858fd8329a0b0a10",
"TruckRide/web/assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"TruckRide/web/assets/fonts/MaterialIcons-Regular.otf": "f9a6387736765311aa2182c762fd2800",
"TruckRide/web/assets/NOTICES": "39cb5b95ff8a7cfa1bedfb461d95ed21",
"TruckRide/web/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"TruckRide/web/assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"TruckRide/web/canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"TruckRide/web/canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"TruckRide/web/canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"TruckRide/web/canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"TruckRide/web/canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"TruckRide/web/canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"TruckRide/web/canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"TruckRide/web/canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"TruckRide/web/canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"TruckRide/web/canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"TruckRide/web/favicon.png": "8f2f8788ef173e69858fd8329a0b0a10",
"TruckRide/web/flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"TruckRide/web/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"TruckRide/web/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"TruckRide/web/icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"TruckRide/web/icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"TruckRide/web/index.html": "dee868dcb6c4ab90480702161c46b560",
"TruckRide/web/main.dart.js": "392320d3c36b949b0aa74bd11498b100",
"TruckRide/web/manifest.json": "572bcdb5a23ed2b0687887745430ae0d",
"TruckRide/web/version.json": "aa5e1c82f37b5ff27c3edaf31b58c610",
"version.json": "aa5e1c82f37b5ff27c3edaf31b58c610"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
