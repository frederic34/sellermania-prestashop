{*
* 2010-2016 Sellermania / Froggy Commerce / 23Prod SARL
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to team@froggy-commerce.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade your module to newer
* versions in the future.
*
*  @author         Froggy Commerce <team@froggy-commerce.com>
*  @copyright      2010-2016 Sellermania / Froggy Commerce / 23Prod SARL
*  @version        1.0
*  @license        http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*}


<form action="" method="post">
    <fieldset>
        <legend><img src="{$sellermania_module_path}logo.gif" alt="" title="" />{l s='Import orders' mod='sellermania'}</legend>

        {if isset($no_namespace_compatibility) && $no_namespace_compatibility eq '1'}
            <p><strong>{l s='Your current PHP version is:' mod='sellermania'} {$php_version}</strong></p>
            <p><strong>{l s='Your PHP version is too old, you must have at least PHP 5.3 to work with Sellermania API.' mod='sellermania'}</strong></p>
            <p><strong>{l s='Please ask your hosting provider to update your PHP version.' mod='sellermania'}</strong></p>
        {else}
            <div class="margin-form" style="padding-left:15px">
                <p><b>{l s='Do you want to import Sellermania orders in PrestaShop?' mod='sellermania'}</b></p><br>
                <input type="radio" name="sm_import_orders" id="sm_import_orders_yes" value="yes" {if $sm_import_orders eq 'yes'}checked="checked"{/if} /> {l s='Yes' mod='sellermania'}
                <input type="radio" name="sm_import_orders" id="sm_import_orders_no" value="no" {if $sm_import_orders eq 'no' || $sm_import_orders eq ''}checked="checked"{/if} /> {l s='No' mod='sellermania'}
            </div>
            <div class="margin-form" style="padding-left:15px" id="sm_import_orders_credentials">
                <p><b>{l s='Please fill up with the informations Sellermania provide you:' mod='sellermania'}</b></p>
                <p><label>{l s='Sellermania e-mail' mod='sellermania'}</label> <input type="text" name="sm_order_email" value="{$sm_order_email}" /></p>
                <p><label>{l s='Token webservices' mod='sellermania'}</label> <input type="text" name="sm_order_token" value="{$sm_order_token}" /></p><br>
                <p><label>{l s='Order endpoint' mod='sellermania'}</label> <input type="text" name="sm_order_endpoint" value="{$sm_order_endpoint}" /></p>
                <p><label>{l s='Confirm order endpoint' mod='sellermania'}</label> <input type="text" name="sm_confirm_order_endpoint" value="{$sm_confirm_order_endpoint}" /></p>
                <p><label>{l s='Inventory endpoint' mod='sellermania'}</label> <input type="text" name="sm_inventory_endpoint" value="{$sm_inventory_endpoint}" /></p>
                {if empty($sm_order_email)}
                    <p><strong><u>{l s='Note:' mod='sellermania'}</u></strong> {l s='These four credentials are provided by Sellermania, if you don\'t have them, please contact Sellermania.' mod='sellermania'}</p>
                {/if}


                <p>
                    <label>{l s='Importation method' mod='sellermania'}</label>

                    <input type="radio" name="sm_import_method" id="sm_import_method_cron" value="cron" {if $sm_import_method eq 'cron'}checked="checked"{/if} /> {l s='Cron' mod='sellermania'}&nbsp;&nbsp;
                    <input type="radio" name="sm_import_method" id="sm_import_method_automatic" value="automatic" {if $sm_import_method eq 'automatic' || $sm_import_method eq ''}checked="checked"{/if} /> {l s='Automatic' mod='sellermania'}
                </p>
                <p id="sm_import_method_cron_configuration">
                    <label>{l s='Cron script to call' mod='sellermania'}</label>
                    php -f {$script_path}/import.php {$sellermania_key}
                </p>



                <p>
                    <label>{l s='Synchronization by reference (optional)' mod='sellermania'}</label>
                    <input type="radio" name="sm_stock_sync_option" id="sm_stock_sync_option_yes" value="yes" {if $sm_stock_sync_option eq 'yes'}checked="checked"{/if} /> {l s='Yes' mod='sellermania'}
                    <input type="radio" name="sm_stock_sync_option" id="sm_stock_sync_option_no" value="no" {if $sm_stock_sync_option eq 'no' || $sm_stock_sync_option eq ''}checked="checked"{/if} /> {l s='No' mod='sellermania'}
                </p><br clear="left" />
                <p id="sm_stock_sync_option_configuration">

                    <b>{l s='Option 1:' mod='sellermania'}</b><br>
                    <input type="radio" name="sm_stock_sync_option_1" id="sm_stock_sync_option_1_yes" value="yes" {if $sm_stock_sync_option_1 eq 'yes'}checked="checked"{/if} /> {l s='Yes' mod='sellermania'}
                    <input type="radio" name="sm_stock_sync_option_1" id="sm_stock_sync_option_1_no" value="no" {if $sm_stock_sync_option_1 eq 'no' || $sm_stock_sync_option_1 eq ''}checked="checked"{/if} /> {l s='No' mod='sellermania'}
                    <br>
                    {l s='This feature allows you to "chain" some references to each other, which will permit to update the stock of all the chained references at the same time.' mod='sellermania'}<br>
                    {l s='Eg: You choose to chain with the 5 first characters of the SKU. If the product\'s SKU of an imported order is "D6HSIQKZJD", all products with SKU begins with "D6HSI" will have their stock updated.' mod='sellermania'}
                    <br><br>

                    <b>{l s='Option 2:' mod='sellermania'}</b><br>
                    <input type="radio" name="sm_stock_sync_option_2" id="sm_stock_sync_option_2_yes" value="yes" {if $sm_stock_sync_option_2 eq 'yes'}checked="checked"{/if} /> {l s='Yes' mod='sellermania'}
                    <input type="radio" name="sm_stock_sync_option_2" id="sm_stock_sync_option_2_no" value="no" {if $sm_stock_sync_option_2 eq 'no' || $sm_stock_sync_option_2 eq ''}checked="checked"{/if} /> {l s='No' mod='sellermania'}
                    <br>
                    {l s='This feature allows you to match the reference of product\'s SKU of an imported order with one of your PrestaShop.' mod='sellermania'}<br>
                    {l s='Eg: You choose to chain with the 5 first characters of the SKU. If the product\'s SKU of an imported order is "D6HSIQKZJD", PrestaShop will associated the product with the first one which SKU begins with "D6HSI".' mod='sellermania'}
                    <br><br>

                    <b>{l s='Configuration:' mod='sellermania'}</b><br>
                    {l s='Define how you want to chain the references, the X first or X last characters of the reference.' mod='sellermania'}<br>
                    {l s='Use the' mod='sellermania'} <input type="text" name="sm_stock_sync_nb_char" value="{$sm_stock_sync_nb_char|intval}" />
                    <input type="radio" name="sm_stock_sync_position" id="sm_stock_sync_position_first" value="first" {if $sm_stock_sync_position eq 'first'}checked="checked"{/if} /> {l s='first' mod='sellermania'}
                    <input type="radio" name="sm_stock_sync_position" id="sm_stock_sync_position_last" value="last" {if $sm_stock_sync_position eq 'last' || $sm_stock_sync_position eq ''}checked="checked"{/if} /> {l s='last' mod='sellermania'}
                    {l s='reference\'s characters.' mod='sellermania'}
                    <br>
                </p>

                <p>
                    <label>{l s='Alert me by e-mail when a reference is not found' mod='sellermania'}</label>
                    <input type="radio" name="sm_alert_missing_ref_option" id="sm_alert_missing_ref_option_yes" value="yes" {if $sm_alert_missing_ref_option eq 'yes'}checked="checked"{/if} /> {l s='Yes' mod='sellermania'}
                    <input type="radio" name="sm_alert_missing_ref_option" id="sm_alert_missing_ref_option_no" value="no" {if $sm_alert_missing_ref_option eq 'no' || $sm_alert_missing_ref_option eq ''}checked="checked"{/if} /> {l s='No' mod='sellermania'}
                </p><br clear="left" />
                <p id="sm_alert_missing_ref_option_configuration">
                    <label>{l s='Your e-mail' mod='sellermania'}</label>
                    <input type="text" name="sm_alert_missing_ref_mail" value="{$sm_alert_missing_ref_mail}" />
                </p>

                <p>
                    <label>{l s='Enable native refund system' mod='sellermania'}</label>
                    <input type="radio" name="sm_enable_native_refund_system" id="sm_enable_native_refund_system_yes" value="yes" {if $sm_enable_native_refund_system eq 'yes'}checked="checked"{/if} /> {l s='Yes' mod='sellermania'}
                    <input type="radio" name="sm_enable_native_refund_system" id="sm_enable_native_refund_system_no" value="no" {if $sm_enable_native_refund_system eq 'no' || $sm_enable_native_refund_system eq ''}checked="checked"{/if} /> {l s='No' mod='sellermania'}
                </p><br clear="left" />

                <p>
                    <label>{l s='Default carrier for order importation' mod='sellermania'}</label>
                    {foreach from=$carriers item=carrier}
                        <input type="radio" value="{$carrier.id_carrier}" name="sm_import_default_carrier" {if $sm_import_default_carrier eq $carrier.id_carrier}checked{/if} /> {$carrier.name}<br>
                    {/foreach}
                </p><br clear="left" />

                <p><label>{l s='Sellermania order state configuration' mod='sellermania'}</label></p><br clear="left" />
                <p>
                    {foreach from=$sm_order_states key=sm_order_state_key item=sm_order_state}
                    <label>{$sm_order_state.label[$documentation_iso_code]} :</label>
                        <select name="{$sm_order_state_key}" id="{$sm_order_state_key}">
                            {foreach from=$ps_order_states item=ps_order_state}
                                <option value="{$ps_order_state.id_order_state}" {if $ps_order_state.id_order_state eq $sm_order_state.ps_conf_value}selected{/if}>{$ps_order_state.name}</option>
                            {/foreach}
                        </select><br>
                    {/foreach}
                </p>

                <p><label>{l s='E-mail associated to customer account created' mod='sellermania'}</label> <input type="text" name="sm_catch_all_mail_address" value="{$sm_catch_all_mail_address}" /></p>

                <p><label><input type="submit" name="import_orders" value="{l s='Validate' mod='sellermania'}" class="button" /></label></p>
                {if isset($sm_error_credentials)}<br><br><p class="error"><strong>{$sm_error_credentials|strip_tags}</strong></p>{/if}
                {if isset($sm_confirm_credentials)}<br><br><p class="conf"><strong>{l s='Configuration is valid' mod='sellermania'}</strong></p>{/if}

                {if $sm_next_import ne ''}
                    <br>
                    <div class="margin-form" style="padding-left:15px">
                        <p>{l s='The last order importation was done:' mod='sellermania'} <b>{$sm_last_import}</b></p>
                        <p>{l s='Next order importation won\'t be done until:' mod='sellermania'} <b>{$sm_next_import}</b></p>
                        {if $nb_orders_in_error gt 0}
                            <br>
                            <h4>{l s='Importation errors:' mod='sellermania'}</h4>
                            <p><b>{$nb_orders_in_error}</b> {l s='orders could not be imported' mod='sellermania'} - <a href="{$module_url}&see=orders-error">{l s='See details' mod='sellermania'}</a></p>
                        {/if}
                        <p>{l s='Product ID used when no product is matched during an order importation:' mod='sellermania'} <strong>{$sm_default_product_id}</strong>{if $sm_default_product->id lt 1} <strong>({l s='WARNING: Product could not be found!' mod='sellermania'})</strong>{/if}</p>
                    </div>
                {/if}
            </div>
        {/if}
    </fieldset>
</form>