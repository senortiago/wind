{*
 * WiND - Wireless Nodes Database
 * Modern sidebar menu
 *}
<div style="padding: 6px 12px 4px; margin-bottom: 4px;">
        <span style="font-size:10px;font-weight:700;letter-spacing:.1em;text-transform:uppercase;color:#334155;">Navigation</span>
</div>

{$main_menu_content}

{if $logged==TRUE}

        {if $is_admin === TRUE || $is_hostmaster === TRUE }

        {if $ranges_waiting != 0 || $ranges_req_del != 0 || $dnszones_waiting != 0 || $dnsnameservers_waiting != 0}
        <div class="hostmaster gadget" style="margin-top:12px;">
                <span class="title">
                        &#x26A1; {$lang.hostmaster_panel}
                </span>
                <ul class="menu">
                {if $link_ranges != '' && ($ranges_waiting != 0 || $ranges_req_del != 0)}
                        <li>
                                <a href="{$link_ranges}">{$lang.ip_ranges}</a>
                        </li>
                        {if $ranges_waiting != 0}
                                <li style="padding:0 8px 4px;">
                                <a class="btn btn-info btn-xs" href="{$link_ranges_waiting}">
                                        <span class="badge">{$ranges_waiting}</span> {$lang.waiting}</a>
                                </li>
                        {/if}
                        {if $ranges_req_del != 0}
                                <li style="padding:0 8px 4px;">
                                <a class="btn btn-warning btn-xs" href="{$link_ranges_req_del}">
                                        <span class="badge">{$ranges_req_del}</span> {$lang.waiting}</a>
                                </li>
                        {/if}
                {/if}
                {if $link_ranges_v6 != '' && ($ranges_v6_waiting != 0 || $ranges_v6_req_del != 0)}
                        <li>
                                <a href="{$link_ranges_v6}">{$lang.ip_ranges_v6}</a>
                        </li>
                        {if $ranges_v6_waiting != 0}
                                <li style="padding:0 8px 4px;">
                                <a class="btn btn-info btn-xs" href="{$link_ranges_v6_waiting}">
                                        <span class="badge">{$ranges_v6_waiting}</span> {$lang.waiting}</a>
                                </li>
                        {/if}
                        {if $ranges_v6_req_del != 0}
                                <li style="padding:0 8px 4px;">
                                <a class="btn btn-warning btn-xs" href="{$link_ranges_v6_req_del}">
                                        <span class="badge">{$ranges_v6_req_del}</span> {$lang.waiting}</a>
                                </li>
                        {/if}
                {/if}
                {if $link_dnszones != '' && $dnszones_waiting != 0}
                        <li>
                                <a href="{$link_dnszones}">{$lang.dns_zones}</a>
                        </li>
                        {if $dnszones_waiting != 0}
                                <li style="padding:0 8px 4px;">
                                <a class="btn btn-success btn-xs" href="{$link_dnszones_waiting}">
                                        <span class="badge">{$dnszones_waiting}</span> {$lang.waiting}</a>
                                </li>
                        {/if}
                {/if}
                {if $link_dnsnameservers != '' && $dnsnameservers_waiting != 0}
                        <li>
                                <a href="{$link_dnsnameservers}">{$lang.dns_nameservers}</a>
                        </li>
                        {if $dnsnameservers_waiting != 0}
                                <li style="padding:0 8px 4px;">
                                <a class="btn btn-success btn-xs" href="{$link_dnsnameservers_waiting}">
                                        <span class="badge">{$dnsnameservers_waiting}</span> {$lang.waiting}</a>
                                </li>
                        {/if}
                {/if}
                </ul>
        </div>
        {/if}

        {/if}

        <div class="node_editor gadget" style="margin-top:12px;">
                <span class="title">
                        &#x1F4F1; {$lang.mynodes}
                </span>
                <ul class="menu node-list">
                {section name=row loop=$node_editor}
                        <li>
                                <a href="{$node_editor[row].url_view|escape}">{$node_editor[row].name|escape} <small class="node-id">#{$node_editor[row].id}</small></a>
                        </li>
                {/section}
                <li style="padding:4px 8px 8px;">
                        <a class="btn btn-success btn-xs" href="{$link_addnode}">+ {$lang.node_add}</a>
                </li>
                </ul>
        </div>

{/if}

<div class="statistics gadget" style="margin-top:12px;">
        <span class="title">
                &#x1F4CA; {$lang.statistics}
        </span>
        <ul class="statistics">
                <li>
                        <span class="quantity">{$stats_nodes_active}/{$stats_nodes_total}</span>
                        <span class="desc">{$lang.active_nodes|lower}</span>
                </li>
                <li>
                        <span class="quantity">{$stats_backbone}</span>
                        <span class="desc">{$lang.backbone_nodes|lower}</span>
                </li>
                <li>
                        <span class="quantity">{$stats_links}</span>
                        <span class="desc">{$lang.links|lower}</span>
                </li>
                <li>
                        <span class="quantity">{$stats_aps}</span>
                        <span class="desc">{$lang.aps|lower}</span>
                </li>
                <li>
                        <span class="quantity">{$stats_services_active}/{$stats_services_total}</span>
                        <span class="desc">{$lang.active_services|lower}</span>
                </li>
        </ul>
</div>
