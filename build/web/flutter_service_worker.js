'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "53b70f86e04d16a9d561091ab2366964",
"assets/AssetManifest.bin.json": "07e1b46fdfce006bf001fe03a1d43f0b",
"assets/AssetManifest.json": "d98dd6abde3cfc7a274ee69b6477baca",
"assets/assets/images/612wu4a5oeL._AC_UF1000,1000_QL80_.jpg": "8524cd2664e7d14dd1cd01e12fd1d72a",
"assets/assets/images/71k-9Uit9SL.jpg": "62a0e2e24f2654a815c4051b21ec024c",
"assets/assets/images/apres.jpg": "1e717fc5aa61ac4a68c1c80e724510d5",
"assets/assets/images/avant.png": "218d2858258f50dd2da77280b040c1c0",
"assets/assets/images/blender-portable-380ml-mixeur.webp": "6c3c182214012c65e13936ebed08bebd",
"assets/assets/images/clients/first_man.png": "7886acf0caddc1452fbd1c2679c00d0c",
"assets/assets/images/clients/fourth_man.jpg": "98a3762f062b3972bea5d01f2aaa9268",
"assets/assets/images/clients/second_man.jpg": "e2f676c7e186698b97ab96facbf59a96",
"assets/assets/images/clients/third_woman.jpg": "0e742afff5b9a626e5b66f47eb98c32d",
"assets/assets/images/first.jpg": "e8a0ce16857310144257910c6f715bbe",
"assets/assets/images/lifestyle_nomad.png": "efa761124c5f1f040ecdb8fbbc5ce04c",
"assets/assets/images/mode_de_vie/doctor.webp": "df024aaaf2c141196dc3621c30662dc4",
"assets/assets/images/mode_de_vie/pret_a_voyage.jpeg": "debda1a896d70132b66cdf2cefaa376b",
"assets/assets/images/mode_de_vie/salle_de_sport.webp": "40c98b0f60285e0af875b9ab6b09226d",
"assets/assets/images/problems/first.jpg": "9f806cce36e1c0ffeb1f2dee355e5050",
"assets/assets/images/problems/second.jpg": "3fb431f44f9605e196235dc560aac93c",
"assets/assets/images/problems/third.jpg": "9615ef8f90d0ffd2a32e34c3d1ad4b7e",
"assets/assets/images/product_features.png": "9cb5ee25618dd868939c264e33bff03f",
"assets/assets/images/recommended/second.jpg": "1f6dd5c138f843194c13d793d7caf19f",
"assets/assets/images/recommended/third.jpg": "0a10315e67c79541bea5264aec100119",
"assets/assets/images/solution/first.jpg": "6244b05e783009f72c0a1c051409aa05",
"assets/assets/images/solution/second.jpg": "612892e1307026f4a0c54495c84eeff4",
"assets/assets/images/solution/third.jpg": "65e44e577da0f0a06da1f7e440ea7887",
"assets/assets/images/testimonials/amelie.png": "d4f1add133511bf484917fed935657c4",
"assets/assets/images/testimonials/marc.png": "443cbc52797082201455eaf1014f82cf",
"assets/assets/images/testimonials/sophie.png": "e7459c0a7de5ca201bf581248d1afdfd",
"assets/assets/product_image.png": "a05af33dce5a1eebc4faa20d20d3ba43",
"assets/assets/videos/first.mp4": "99b250957ffd4887c02f540556aa714f",
"assets/assets/videos/fourth.mp4": "f404c286067dab33937677fe29b47845",
"assets/assets/videos/second.mp4": "3861c8eda90038d77fa35ce858fc6202",
"assets/assets/videos/third.mp4": "df3fe8e202980c1a5bfdee60e21b8a6b",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "dcab9ee2b64541b135173dfd8c2d246e",
"assets/NOTICES": "fc0b665cbac2f0e29f96eb88082735ab",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/web/icons/Icon-512.png": "6f50e2af09f6413a5678d21ef4fc262a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon-32x32%20copy.png": "3e5a28c244a07c84ca5fc42af275d507",
"favicon.png": "37c6e841b88a8882a96a015ba95bfcb8",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "e93f0df3c4d32a0550f02c7734883d02",
"icons/Icon-192.png": "1fc1e6c05f6f6d2e6057b06092890171",
"icons/Icon-512.png": "6f50e2af09f6413a5678d21ef4fc262a",
"icons/Icon-maskable-192.png": "1fc1e6c05f6f6d2e6057b06092890171",
"icons/Icon-maskable-512.png": "6f50e2af09f6413a5678d21ef4fc262a",
"index.html": "0f9bfee74d2e9da9cf940ad427dffe62",
"/": "0f9bfee74d2e9da9cf940ad427dffe62",
"main.dart.js": "7aeec188074aa98fe4e94d670b6ee052",
"manifest.json": "cbe466c0d6c459cc87027b7d4636584a",
"version.json": "e157a30a5736526bf392d617f17cf0c3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
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
