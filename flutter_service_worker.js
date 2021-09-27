'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  ".git/COMMIT_EDITMSG": "73485da4abdcaab6c765055d65e430af",
".git/config": "9581728692914d1904232d3ee5dcaeb9",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "9d2d4519bcd6ab91567c6ac8872dad66",
".git/HEAD": "9e402a976ce6eea0a6fe509b135e8317",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "ea587b0fae70333bce92257152996e70",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "3c5989301dd4b949dfa1f43738a22819",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/update.sample": "7bf1fcc5f411e5ad68c59b68661660ed",
".git/index": "be3bc444c3f56235c496455a2888f355",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "8a41fe301ffe4b879a22d92890ebe37d",
".git/logs/refs/heads/webBuild": "f3153517dca3ed2a276cc97dec0a49cc",
".git/logs/refs/remotes/origin/main": "8f57d5b12d45ca1a15fc1a9ec0ef6df2",
".git/logs/refs/remotes/origin/master": "03081a3c2353fae6553f3d45f3277a33",
".git/logs/refs/remotes/origin/webBuild": "cb4e17017188ecaec89be634411ac228",
".git/objects/07/dd7731082d9a395df841dc1b17b554bd78d88d": "503d00b8c6c449f5ee307500261288a2",
".git/objects/08/505ff5840fb845c90e28a2efff3377ab5513c3": "718165935a98faffd44f06c6dcb590ee",
".git/objects/0a/d395b4be44af98b9188f669106edc82ceefbd8": "ba4da6226b96b92313fca78547f6a963",
".git/objects/20/5bb5db271c6d8de8399864c7bb9b917f638893": "c993b22f115d7f3ae6d5b7b212806539",
".git/objects/21/39b8f9bc691cdc344f2144116cd4c40120a525": "93443ecfd36686b4ea16abac7cc46902",
".git/objects/23/9d69dc23299efaf89c57c0879b9c18a56919ed": "dbb7f0b3fc967e97fc8a17984de7c584",
".git/objects/28/002d2669a1856b9af9cbd07974c0622826a322": "010e437deabaf1ea6b3ceb876c025ad2",
".git/objects/28/eb6aa80312835373873c4cf118047cd54e53f8": "c07e722c6408f74a627970e4d5eb0b61",
".git/objects/2f/d3705c164e81df95e01e25b7f7abe85d102f6a": "2241ffefe30d3a2b0773b577de7550a4",
".git/objects/33/a6943ac6756e0f7d2f30b6b642cd40f1993359": "c36aedcd2792f751113258d847f9137f",
".git/objects/34/0965abf713d94ad056241bdabcba10e29f466e": "2e077848ce81e0a1b9757b562353b862",
".git/objects/36/a4bb3412ab3269ed5b86bfc4b2f71e815cf078": "7e7dadd0ae84705a9f29471174b477d2",
".git/objects/38/bc7173e4ad2aaede264776cbe3cb3b7ac7b7c8": "dc3f9cf959da52d1a4d89e7ee0dca297",
".git/objects/3a/bd62387a3e2d22fd0d1d6b350800e7a2c3ab19": "0b8830e639261febf1b679d098a9f005",
".git/objects/40/c3dd5811f85d5006876dd6a49745ee3105d5d4": "f8a544ef95f14f619adf200da3679e42",
".git/objects/41/42c6b838ddced89f0f132ed2523397292511da": "7334e40937fd289a08c00fe5311b56c0",
".git/objects/47/f5330569d68916f87207dbfc9b72ceac027db7": "b756798f12a6f946e61cd6a83a59f2d8",
".git/objects/4c/8f2e2b94a8d1328d57eab9f88695afb9e9f6fd": "4016f8af9914e3ed05653a1a376d82ad",
".git/objects/57/151b8fb2640e7b5cad38dfca6f68c0d8e49095": "bcd5758ec301db02edeeb4f4b230e4ef",
".git/objects/58/e766ea8f1fc6034ea55100f1bf56be04f4e909": "d67762288f0735c610633dd53d61df2d",
".git/objects/61/c829910e5ec4ee4f70dd1760479d99445c6c72": "682ef3b7b385a4f5cf89db3d1ce4a984",
".git/objects/73/7760b5df73bf4e48e8d17146a574e8deabc80d": "13d16aef91d25b6dde089b816cc1d6a7",
".git/objects/76/d520b2bd4d58d9973ee6b1d0dde342ace64726": "7f5d4d19882b8f519db432ca09f6fc5d",
".git/objects/77/a77efb84c27a8fbe36a439b4aed882ea350d1c": "7df5617eb84ae2831519d6bc9dfc0122",
".git/objects/78/d5463f36f13af6410a8f39e8a4d667d1f15bcc": "da4a42c9edfd739d6bdfe3cb3e53c476",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/7c/29eeb911b35707f2ff5aa69c6cb6d8a30514d2": "49fd8fc89b264ccf8a14f441d0073670",
".git/objects/81/1bd762e7d281c4c07ceddd64250bb18cac8b54": "94338b8f3ef3d91cdd896c526c9631a1",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/69f8dcffce257bd33a3eab4ec13879d7449992": "449f78218eb403e808cb35a3f1af2026",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/9d/365241d8f0d170986db661c670c358a021e2c8": "29a738f9f90a791a0bb75b8528199d83",
".git/objects/9d/86e6d9929280813275d5dfdc2c2216a03e2e8f": "714e72329de9a09b960a71d2ee760690",
".git/objects/9f/4878b896acfc831083d2be28cfe8809dad3bb2": "b0ebfcaf2932b12d72924992c55fcd59",
".git/objects/a0/4f510a216459419cfd772b3cd0799dccdd25de": "4705890b5926d55d5a61324773b0380f",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/a4/2b9410fc295d09056573a49358cc9851b28602": "329166fac88929464eeb15da0759f5a6",
".git/objects/a8/3a17d54b6dc2156c855c6580301cefc9c8d017": "6525101be8d70b808a809af9c83fa4ad",
".git/objects/a8/e136698fe7206bab96d750679e4b6c63a13c1e": "0ee5af9ead598106c1f5122a75ff04bb",
".git/objects/ab/0e98497a51ead7821d1da35a24968ff314e50f": "557c35fe3928eb2af403d1b3926bb9ba",
".git/objects/af/18eaf4a829d4b8bc3f0367d9d534bb4b14b297": "38282454c6f81af09bdef9571074057a",
".git/objects/af/229d5b3d67f0a4bc232f675c07af41e92e9ec4": "fb20b90769171a010a8aec57d1b50335",
".git/objects/b0/e9554f9580777b5457ef3a64fc1f5d5ceb62b8": "6f8eea829ddcf6941ea366a8b2ca5162",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/cf/bc5d5d6bf3fc3beff527562b479e5755842ae2": "8f8f642380b74309dbc33cd8e3d66db0",
".git/objects/d1/5e86cd7748bdab00d8472889fad41e059b03ef": "112f43078ee209bded37c6c76319337a",
".git/objects/d7/45b6b284362f7004f3f2c94b890a68b3c170a6": "2106d0c857ea5847d5321645f8124226",
".git/objects/db/009abb7b6a044a5445d95e3c999a5ca2f83017": "c94f61c85ef964b65be897b08862280e",
".git/objects/de/4fb758f55293744a6872055ed29e11df5f367d": "18eeb34cf8ad952d26b079913c3ba22a",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/ef/1daf27cc59907975a5ffd42ab3a7b0980e3883": "e911b601b78bb385c1e3a282684a5095",
".git/objects/ef/8bf86498b13e70a94142e749320de120fa5e08": "9023dab05e5ae9602afac17ae6aa95e0",
".git/objects/f2/5787c93ad00665f0f797a43ab397f0628a273e": "59e425d1456034072d902c75d18ec75f",
".git/objects/f4/bca0d87625d087f72e23ac68dde30af3329289": "b23f23082dfe36eea2a2c5a92f82181e",
".git/objects/f9/889d0a16ede57dd48a1e868ec2782f9d65fbf5": "7e8598b283b35fbb4390e7dbebac368d",
".git/objects/f9/dda69aa742cef894b93840a2287604c75f3643": "99678b7b75f9397f4ef52930a49ad774",
".git/objects/pack/pack-8262025123e3fe43b4dcb0c35acdf87e3927be2c.idx": "0473359784efcc4759f9bf9043c3e793",
".git/objects/pack/pack-8262025123e3fe43b4dcb0c35acdf87e3927be2c.pack": "15f027b63e8bba8a0f96a391fbeded72",
".git/ORIG_HEAD": "60bfb91ba73cf8c8df31058960c97c7a",
".git/refs/heads/webBuild": "55567ed13fefa5512167932fcf256fbc",
".git/refs/remotes/origin/main": "dabb3497f8f5dab962d77525547c65db",
".git/refs/remotes/origin/master": "62f9537603d90314512cfb98f97dc2ab",
".git/refs/remotes/origin/webBuild": "55567ed13fefa5512167932fcf256fbc",
"assets/AssetManifest.json": "b319f0266f9df6a60f467a9f62d0f455",
"assets/FontManifest.json": "1ceb4124e19911087856da5f55f3e36f",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/lib/assets/fonts/Metropolis-Black.otf": "de55ae52af85b8952e65d1b546992618",
"assets/lib/assets/fonts/Metropolis-Bold.otf": "dea4998b081c6c1133a3b5b08ff2218c",
"assets/lib/assets/fonts/Metropolis-Medium.otf": "f4bca87fd0d19e61c27dc96299c75f8c",
"assets/lib/assets/fonts/Metropolis-Regular.otf": "f7b5e589f88206b4bd5cb1408c5362e6",
"assets/lib/assets/fonts/Metropolis-SemiBold.otf": "2556a4f74e2c523893e6928d6e300f1c",
"assets/lib/assets/images/2.0x/landing.png": "47d20676d102789c2fe69b74c186ef4b",
"assets/lib/assets/images/3.0x/landing.png": "d6f28b00c7b3dc1e485125c7f9509030",
"assets/lib/assets/images/landing.png": "205aa51592834bfd5a6a4e9ba054c70c",
"assets/lib/assets/images/profile.jpeg": "404126f1c96afffaab9a238f7bc678c0",
"assets/NOTICES": "66aaa9c05727f4579a7c9a1ed6f9a871",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon-32x32.png": "7ad3bca4550c77f3b1606ff228fc52a6",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "0ec6dbd86af666de738e5ccf77a12318",
"/": "0ec6dbd86af666de738e5ccf77a12318",
"main.dart.js": "71229d07ea77363b1b11c6da0a2bf44a",
"manifest.json": "19c0dd3d35868e5fefd77f47b8dc9364",
"version.json": "1b2d3ce919dd444c5fe6de9de0b6a9fe"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
