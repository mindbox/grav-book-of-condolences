<?php
namespace Grav\Plugin;

use Composer\Autoload\ClassLoader;
use Grav\Common\Plugin;
use Grav\Events\FlexRegisterEvent;

use Grav\Plugin\Form;
use Grav\Common\Form\FormFlash;
use RocketTheme\Toolbox\Event\Event;

/**
 * Class CondolencePlugin
 * @package Grav\Plugin
 */
class CondolencePlugin extends Plugin
{
    public $features = [
        'blueprints' => 0,
    ];

    /**
     * @return array
     *
     * The getSubscribedEvents() gives the core a list of events
     *     that the plugin wants to listen to. The key of each
     *     array section is the event that the plugin listens to
     *     and the value (in the form of an array) contains the
     *     callable (or function) as well as the priority. The
     *     higher the number the higher the priority.
     */
    public static function getSubscribedEvents(): array
    {
        return [
            'onPluginsInitialized' => [
                // Uncomment following line when plugin requires Grav < 1.7
                // ['autoload', 100000],
                ['onPluginsInitialized', 0]
            ],
            FlexRegisterEvent::class       => [['onRegisterFlex', 0]],
            'onFormProcessed' => ['onFormProcessed', 0],
        ];
    }

    /**
     * Composer autoload
     *
     * @return ClassLoader
     */
    public function autoload(): ClassLoader
    {
        return require __DIR__ . '/vendor/autoload.php';
    }

    /**
     * Initialize the plugin
     */
    public function onPluginsInitialized(): void
    {
        // Don't proceed if we are in the admin plugin
        if ($this->isAdmin()) {
            return;
        }

        // Enable the main events we are interested in
        $this->enable([
            // Put your main events here
        ]);
    }

    public function onRegisterFlex($event): void
    {
        $flex = $event->flex;

        $flex->addDirectoryType(
            'goodbye',
            'blueprints://flex-objects/goodbye.yaml'
        );

    }

    /* custom form processing step */
    // https://discord.com/channels/501836936584101899/501854266873348112/1077319288446275716
    public function onFormProcessed(Event $event)
    {
        $form = $event['form'];
        $action = $event['action'];

        switch ($action) {
            case 'condolence':
                $this->processForm($form, $event);
                break;
        }
    }

/*
    form config:

    process:
        condolence: true
    */
    public function processForm(Form $form, $event): bool
    {
        $form->validate();

        /** @var Flex $flex */
        $flex = $this->grav['flex'];
        /** @var FlexDirectory $dir */
        $dir = $flex->getDirectory('goodbye');

        /** @var array $data */
        $data = $form->getData()->toArray();

        // not initially published
        $data['date'] = date('Y-m-d H:i');
        $data['published'] = false;

        // clean up
        unset( $data['personality'] );
        unset( $data['privacy'] );

        // create flex object
        $obj = $dir->createObject($data, '');
        $obj->save();

        return true;
    }
}
