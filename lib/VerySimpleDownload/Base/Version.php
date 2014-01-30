<?php
/**
 * VerySimpleDownload.
 *
 * @copyright Ralf Koester (Koester)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package VerySimpleDownload
 * @author Ralf Koester <ralf@zikula.de>.
 * @link http://support.zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.1 (http://modulestudio.de) at Mon Jan 20 19:00:40 CET 2014.
 */

/**
 * Version information base class.
 */
class VerySimpleDownload_Base_Version extends Zikula_AbstractVersion
{
    /**
     * Retrieves meta data information for this application.
     *
     * @return array List of meta data.
     */
    public function getMetaData()
    {
        $meta = array();
        // the current module version
        $meta['version']              = '1.0.0';
        // the displayed name of the module
        $meta['displayname']          = $this->__('Very simple download');
        // the module description
        $meta['description']          = $this->__('Very simple download module generated by ModuleStudio 0.6.1.');
        //! url version of name, should be in lowercase without space
        $meta['url']                  = $this->__('verysimpledownload');
        // core requirement
        $meta['core_min']             = '1.3.5'; // requires minimum 1.3.5
        $meta['core_max']             = '1.3.6'; // not ready for 1.3.7 yet

        // define special capabilities of this module
        $meta['capabilities'] = array(
                          HookUtil::SUBSCRIBER_CAPABLE => array('enabled' => true)
/*,
                          HookUtil::PROVIDER_CAPABLE => array('enabled' => true), // TODO: see #15
                          'authentication' => array('version' => '1.0'),
                          'profile'        => array('version' => '1.0', 'anotherkey' => 'anothervalue'),
                          'message'        => array('version' => '1.0', 'anotherkey' => 'anothervalue')
*/
        );

        // permission schema
        $meta['securityschema'] = array(
            'VerySimpleDownload::' => '::',
            'VerySimpleDownload::Ajax' => '::',
            'VerySimpleDownload:ItemListBlock:' => 'Block title::',
            'VerySimpleDownload:ModerationBlock:' => 'Block title::',
            'VerySimpleDownload:Download:' => 'Download ID::',
        );
        // DEBUG: permission schema aspect ends


        return $meta;
    }

    /**
     * Define hook subscriber bundles.
     */
    protected function setupHookBundles()
    {
        
        $bundle = new Zikula_HookManager_SubscriberBundle($this->name, 'subscriber.verysimpledownload.ui_hooks.downloads', 'ui_hooks', __('verysimpledownload Downloads Display Hooks'));
        
        // Display hook for view/display templates.
        $bundle->addEvent('display_view', 'verysimpledownload.ui_hooks.downloads.display_view');
        // Display hook for create/edit forms.
        $bundle->addEvent('form_edit', 'verysimpledownload.ui_hooks.downloads.form_edit');
        // Display hook for delete dialogues.
        $bundle->addEvent('form_delete', 'verysimpledownload.ui_hooks.downloads.form_delete');
        // Validate input from an ui create/edit form.
        $bundle->addEvent('validate_edit', 'verysimpledownload.ui_hooks.downloads.validate_edit');
        // Validate input from an ui create/edit form (generally not used).
        $bundle->addEvent('validate_delete', 'verysimpledownload.ui_hooks.downloads.validate_delete');
        // Perform the final update actions for a ui create/edit form.
        $bundle->addEvent('process_edit', 'verysimpledownload.ui_hooks.downloads.process_edit');
        // Perform the final delete actions for a ui form.
        $bundle->addEvent('process_delete', 'verysimpledownload.ui_hooks.downloads.process_delete');
        $this->registerHookSubscriberBundle($bundle);

        $bundle = new Zikula_HookManager_SubscriberBundle($this->name, 'subscriber.verysimpledownload.filter_hooks.downloads', 'filter_hooks', __('verysimpledownload Downloads Filter Hooks'));
        // A filter applied to the given area.
        $bundle->addEvent('filter', 'verysimpledownload.filter_hooks.downloads.filter');
        $this->registerHookSubscriberBundle($bundle);

        
    }
}