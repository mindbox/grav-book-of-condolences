<?php
namespace Grav\Theme;

use Grav\Common\Grav;
use Grav\Common\Theme;

class Condolence extends Theme
{
    public static function getSubscribedEvents()
    {
        return [
            'onThemeInitialized'    => ['onThemeInitialized', 0],
            'onTwigLoader'          => ['onTwigLoader', 0],
            'onTwigInitialized'     => ['onTwigInitialized', 0],
        ];
    }

    public function onThemeInitialized()
    {
        if ($this->isAdmin()) {
            $this->enable([
                'onAssetsInitialized' => ['onAdminAssetsInitialized', 0],
            ]);
        }
    }

    // Add images to twig template paths to allow inclusion of SVG files
    public function onTwigLoader()
    {
        $theme_paths = Grav::instance()['locator']->findResources('theme://dist/img');
        foreach($theme_paths as $images_path) {
            $this->grav['twig']->addPath($images_path, 'images');
        }
    }

    // fancy custom classes for form elements
    public function onTwigInitialized()
    {
        $twig = $this->grav['twig'];

        $form_class_variables = [
            // 'form_outer_classes' => 'form-horizontal',
            'form_button_outer_classes' => 'form__buttons',
            'form_button_classes' => 'button',
            'form_errors_classes' => '',
            'form_field_outer_classes' => 'form__field',
            'form_field_outer_label_classes' => 'form-label-wrapper',
            'form_field_label_classes' => 'form__label',
            // 'form_field_outer_data_classes' => 'col-9',
            'form_field_input_classes' => '',
            'form_field_text_classes' => 'text-input',
            'form_field_textarea_classes' => 'text-input',
            'form_field_select_classes' => 'text-input dropdown',
            'form_field_radio_classes' => 'form__radio radio',
            'form_field_checkbox_classes' => 'form__checkbox checkbox',
        ];

        $twig->twig_vars = array_merge($twig->twig_vars, $form_class_variables);
    }



    /**
     * [onAdminAssetsInitialized]
     *
     * @return void
     */
    public function onAdminAssetsInitialized()
    {
        $assets = $this->grav['assets'];
        // $page = $this->grav['admin']->page();
        // if( $page->isPage() ) {}

        // admin & editor styles
        $assets->addCss( 'theme://dist/css/admin.css' );
        // editor buttons
        if ($this->config->get('plugins.markdown-notices.enabled')) {
            $assets->add( 'theme://admin/buttons/notice.js', [ 'defer' => true ] );
        }
    }


}