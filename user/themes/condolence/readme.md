# Grav Theme Condolence

This is the theme for the digital book of condolences. It's based on the [boilerplate 'Chassis'](https://github.com/bitstarr/grav-theme-chassis).

## File Structure

````
.
├── /.tasks             node scripts (see package.json)
├── /admin              Admin modifications and enhancements
│   └── /buttons            Editor buttons
├── /assets             "raw" assets
│   ├── /css                CSS files
│   │   ├── /base               settings, normalization, helper
│   │   ├── /form               form components
│   │   ├── /molecule           simple modules
│   │   ├── /oranism            complex modules
│   │   ├── /template           template/page specifics (e.g. spacing)
│   │   ├── admin.css           admin style modifications
│   │   └── main.css            main style sheet
│   ├── /favicon            favicons/app icons
│   ├── /img                static images
│   │   └── canlde.svg          default logo (a candle)
│   └── /js                 JS files
│       ├── /src                JS (bundle) source files
│       ├── dev.json            JS helper bundle for local enviroment
│       └── main.json           JS base bundle.
├── /blueprints         grav blueprints for page types
├── /dist               build files
│   ├── /css                minified CSS files
│   ├── /favicons           optimized favicons
│   ├── /img                optimized images
│   └── /js                 minified JS files and bundles
├── /langages           translation files
├── /templates          grav templates
│   ├── /forms              custom form elements for better styling
│   ├── /partials           template parts
│   └── *.html.twig         page templates
├── .eslintrc           eslint config
├── .styleintrc         styleint config
├── condolence.php      theme functions
├── condolence.yaml     theme config file
└── package.json
````

## CSS Processing

We are using PostCSS for convenience. It will inline `@import`, resolve nesting and autoprefix.

`/assets/css/main.css` is the main CSS file and hub. You'll find only imports inside, which will be inlined in processing. If you need to, you can add other CSS files in parallel to main.css to provide other subsets or differently scoped styles. Every CSS file stored directly in `/assets/css/` will be processed and the result stored in `/dist/css/`.

## JS Files und Bundles

In ``/assets/js`` you will find .js and .json files, as well as a `src` folder. In this setup (no webpack or other advanced magic) the JS files are independent functional components. JSON files are the base for bundles. With these, you can concatenate multiple components from the `src` folder as well as libraries from `/node_modules` which you installed via npm (see example below). In bundles, the order is important. The libs will appear before the code from `src`.

Every JS file in ``/assets/js`` will be copied in ``/dist/js``. Bundles will run through a combination of their parts and the result will be saved as js in ``/dist/js``. Please be aware that there will be conflicts if the filenames of a bundle and a standalone component are the same (foobar.js and foobar.json for example).

````json
{
    "lib": [
        "choices.js/public/assets/scripts/choices.min.js"
    ],
    "src": [
        "form.js",
        "userprofile.js"
    ]
}
````

## Images

All image files in `/assets/img` will be optimized on build (or called manually) using `imagemin` (svgo, pngQuant, mozJpeg, gifsicle, Zopfli) and stored in `/dist/img`. When using the watch task, images will simply be copied to avoid waiting times in development.

## About `/dist`

If you are using a CI server, you can add the `/dist` folder to `.gitignore`. Otherwise, you should make a build before every merge with your main branch, so the main branch includes the minified and most optimized assets in `/dist`.

## Configuration

In `package.json` you will find an onject called `config`. Here are paths stored that are used by the node scripts.

## Task Runner

Wir use node scripts as a task runner. To make use of it, you need to run `npm install` of cause.

| command | function |
|---|---|
| npm run css | processes the CSS files and saves them with source maps to `/dist/css` |
| npm run cssmin | same as `css` but with minifying |
| npm run js | creates JS bundles and copies JS files to `/dist/js` |
| npm run jsmin | same as `js` but with minifying |
| npm run lint | checks CSS and JS assets for bad coding styles and errors |
| npm run img | simply copies images from `/assets/img` to `/dist/img` |
| npm run imgmin | optimizes images and saves results to `/dist/img` |
| npm run favicons | creates favicon files from `/dist/favicons/favicon.svg` and saves them in `/dist/` - move them from here |
| npm run watch | watch for changes and process changed or new files |
| npm run todo | find all occurances of `todo` |
| npm run clean | clear `/dist` |
| npm run dev | runs `css`, `js` and `img` in parallel once |
| npm run build | runs `lint`, `clean`, `cssmin`, `jsmin` and `imgmin` |