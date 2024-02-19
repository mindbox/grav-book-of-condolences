# Book of condolences

A ready-to-go book of condolences made with [grav](https://getgrav.org).

## Background

Life can sometimes hit hard. A valued employee of a client passed away suddenly. We were contacted at midday with a condolence website that had to be online the next day. Thanks to good boilerplates, we were able to deliver it by the evening.

We have now turned the quick shot into a ready-made solution and are making it available to everyone, so at least this is nothing to worry about in that situation.

Currently, there are translations for English and German.

## Installation

To get up and running:

````
make install
````

After installation, you find the admin interface under `/backoffice` (because customized login URLs fight off some bots and script kiddies).

### What install does

* Download and extract the latest grav
* Remove unnecessary stuff from the download
* Move the downloaded grav to the root directory, so it's also your webroot
* Install plugins and themes defined in ``user/.dependencies``
* Sets your preferred language

## Customizing content and moderation

What can/should be customized:

* Farewell text
* Image of the decedent 
* End date for submissions
* Logo (optional)
* Translations

First you want to change the title, farewell text and image you can see on the home page. This can be done in the admin interface. Make sure you select the new image as a page image (setting in the lower part). You can also set the date when to stop submissions (the form will not be displayed after that).

The page image will be automatically be grayscale and is also going to be used as an Open Graph image (social share thingy…).

If you plan to use a logo (like in our case, since it was in the context of the company), you need to upload the logo file to the home page too and then adjust the theme setting (by selecting the logo file).

In case you need to change texts beyond the ones mentioned above, check the translations in the theme folder (`user/themes/condolence/languages/`).

If you want to make use of password recovery emails (for the admin login), you will need to customize the email settings in `user/config/plugins/email.yaml`.

The frontend language is set in user/config/site.yaml and user/config/system.yaml.

## Spam protection

In the form configuration (Frontmatter of /user/pages/01.home/condolences.md) we have a honeypot field. If you encounter bots, that take this hurdle, we recommend using a quiz (asking for where the Paris Eiffel Tower is located) instead. It's already inside the .md file, but commented.

Replace the honeypot with this quiz (translations already included).

```yaml
    personality:
      id: field-personality
      outerclasses: text-input
      label: THEME_C.FORM.FIELD.SPAM_Q
      type: radio
      options:
        berlin: Berlin
        paris: Paris
        newyork: New York
      validate:
        required: true
        pattern: "^paris$"
        message: THEME_C.FORM.FIELD.SPAM_FAIL
```

## Contributing translations

Currently, there are translations for English and German.

If you would like to help with translating the project, add the following files by copying and modifying another translation:

* user/pages/99.imprint/default.XX.md
* user/pages/99.privacy/default.XX.md
* user/pages/error/error.XX.md
* user/plugins/condolence/languages/XX.yaml
* user/themes/condolence/languages/XX.yaml

Since we are not native English speakers, we are looking forward to any corrections for the English translation.

## CLI commands for convinience

| command        | function                                         |
| -------------- | ------------------------------------------------ |
| `make install` | install everything to run the project            |
| `make update`  | update grav and plugins to latest stable version |
| `make clear`   | clear cache                                      |

## Customizing the theme

If you need to modify the theme in any way, make sure to read the [readme]( ./user/themes/condolence/readme.md).

You can use ddev for local development, and here are some handy Make commands for development.

| command          | function                              |
| ---------------- | ------------------------------------- |
| `make themeinit` | install dependencies for theme builds |
| `make watch`     | development mode                      |
| `make lint`      | lint frontend code                    |
| `make build`     | build frontend code for release       |
| `make jsmin`     | quick build of js for release         |
| `make cssmin`    | quick build of css for release        |

