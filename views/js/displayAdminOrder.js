/*
 * 2010-2020 Sellermania / Froggy Commerce / 23Prod SARL
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
 *  @copyright      2010-2020 Sellermania / Froggy Commerce / 23Prod SARL
 *  @version        1.0
 *  @license        http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 */

$(document).ready(function() {

    // Fill product details
    var nb_buttons = 0;
    for (i = 1; sellermania_block_products_list[i]; i++)
    {
        var sm_block_product = sellermania_block_products_list[i];

        var sku_short = sm_block_product.html().split('<br>');
        if (typeof sku_short[1] !== 'undefined') {
            sku_short = sku_short[1];
        } else {
            sku_short = sku_short[0];
        }
        sku_short = sku_short.replace(/(\r\n|\n|\r)/gm, "").replace(/\s+/g, ' ').trim()

		sku_short = sku_short.replace('Numéro de référence', 'Ref').replace('Reference number', 'Ref');
		var remove = sku_short.trim().split(' ');
        if (remove[1] == ':')
            sku_short = sku_short.replace(remove[0] + ' ' + remove[1], '').trim();
        else
            sku_short = sku_short.replace(remove[0], '').trim();

        if (sku_short != '' && typeof sellermania_products[sku_short] != 'undefined')
        {
            var html_order_line = '';
            if (sellermania_products[sku_short].insurance_price > 0)
                html_order_line += '<br><u>' + insurance_price_label + '</u> <b>' + sellermania_products[sku_short].insurance_price + ' ' + sellermania_products[sku_short].currency + '</b><br>';
            if (sellermania_products[sku_short].order_item_id != '') html_order_line += '<br><u>' + order_item_id_label + '</u> <b>' + sellermania_products[sku_short].order_item_id + '</b><br>';
            if (sellermania_products[sku_short].external_order_id != '') html_order_line += '<br><u>' + external_order_id_label + '</u> <b>' + sellermania_products[sku_short].external_order_id + '</b><br>';
            html_order_line += '<u>' + sku_label + '</u> <b>' + sellermania_products[sku_short].sku + '</b><br>';
            if (sellermania_products[sku_short].ean != '') html_order_line += '<u>' + ean_label + '</u> <b>' + sellermania_products[sku_short].ean + '</b><br>';
            if (sellermania_products[sku_short].product_id != '') html_order_line += '<u>' + asin_label + '</u> <b>' + sellermania_products[sku_short].product_id + '</b><br>';
            if (sellermania_products[sku_short].item_condition != '')
                html_order_line += '<u>' + condition_label + '</u> <b>' + sellermania_products[sku_short].item_condition + '</b><br>';
            else
                html_order_line += '<u>' + condition_label + '</u> <b>' + unknown_label + '</b><br>';
            
            var item_status = sellermania_products[sku_short].status;
            if(sellermania_products[sku_short].status_id == 1){
                item_status += '<span><a href="javascript:void(0);" class="linktoscroll">&nbsp;('+linktoshipping_label+')</span>';
            }
            
            html_order_line += '<u>' + status_label + '</u> <b>' + item_status + '</b><br>';
            
            if (sellermania_products[sku_short].status_id == 6)
            {
                html_order_line += '<input type="radio" id="status_confirm_' + i + '" name="status_' + i + '" value="9" class="status_order_line" data-toggle="' + sellermania_products[sku_short].sku + '" /> ' + confirm_label + ' ';
                html_order_line += '<input type="radio" id="status_cancel_' + i + '" name="status_' + i + '" value="4" class="status_order_line" data-toggle="' + sellermania_products[sku_short].sku + '" /> ' + cancel_label + ' ';
                nb_buttons++;
            }

            let attr_href = sm_block_product.parent().attr('href');
            if (typeof attr_href !== 'undefined' && attr_href !== false) {
                sm_block_product.parent().after(html_order_line);
            } else {
                sm_block_product.append(html_order_line);
            }
        }
    }

    $('.linktoscroll').on('click', function() {
        var target = $('#shipping_name');
        target = target.length ? target : $('[name=' + this.hash.substr(1) +']');
        if (target.length) {
            $('html,body').animate({
                scrollTop: target.offset().top
            }, 1000);
            return false;
        }
    });
   
    // Add button check all
    if (nb_buttons > 0)
    {
        var sellermania_html_buttons_all = '<input type="button" value="Confirm all products" id="sellermania_confirm_all_products" class="button btn btn-default" />';
        sellermania_html_buttons_all += '<input type="button" value="Cancel all products" id="sellermania_cancel_all_products" class="button btn btn-default" />';
        sellermania_block_product_general_legend.html(sellermania_html_buttons_all);
        sellermania_block_product_general_legend.show();

        $('#sellermania_confirm_all_products').click(function() {
            for (i = 1; sellermania_block_products_list[i]; i++)
                $('#status_confirm_' + i).attr('checked', 'checked');
            sellermania_update_line_status();
        });
        $('#sellermania_cancel_all_products').click(function() {
            for (i = 1; sellermania_block_products_list[i]; i++)
                $('#status_cancel_' + i).attr('checked', 'checked');
            sellermania_update_line_status();
        });
    }

    // If status has changed
    if (sellermania_status_update_result !== 'undefined')
        sellermania_block_product_general_legend.after(sellermania_status_update_result);
    if (sellermania_error_result !== 'undefined')
        sellermania_block_product_general_legend.after(sellermania_error_result);


    // Check status
    $('.status_order_line').click(function() {
        sellermania_update_line_status();
    });


    function sellermania_update_line_status()
    {
        // Fill product details
        var line_max = 0;
        var sellermania_status_defined = 0;
        for (let i = 1; sellermania_block_products_list[i]; i++)
        {
            // Status
            var order_line_status = 'Not defined';
            if ($('#status_confirm_' + i).attr('checked') || $('#status_confirm_' + i).is(':checked')) {
                order_line_status = 'Confirmed';
            }
            if ($('#status_cancel_' + i).attr('checked') || $('#status_cancel_' + i).is(':checked')) {
                order_line_status = 'Cancelled';
            }

            // Count not defined Status
            if (order_line_status != 'Not defined') {
                sellermania_status_defined++;
            }

            // Save the line max
            line_max = i;
        }

        // Check how many not defined status there is
        if (sellermania_status_defined > 0)
        {
            // Display submit
            sellermania_block_product_general_legend.html('<input type="button" id="sellermania_register_status" value="Apply" class="button btn btn-default" />');

            // Generate form and submit it
            $('#sellermania_register_status').click(function() {

                // Generate form
                var html_form = '<input type="hidden" name="sellermania_line_max" value="' + line_max + '" />';
                $('.status_order_line').each(function() {
                    if ($(this).attr('checked') || $(this).is(':checked'))
                    {
                        html_form += '<input type="hidden" name="' + $(this).attr('name') + '" value="' + $(this).attr('value') + '" />';
                        html_form += '<input type="hidden" name="sku_' + $(this).attr('name') + '" value="' + $(this).attr('data-toggle') + '" />';
                    }
                });

                // Display form and submit
                $('#sellermania_status_form').html(html_form);
                document.forms["sellermania_status_form"].submit();

                return false;
            });
        }
    }
});
