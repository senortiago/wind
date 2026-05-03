{*
 * WiND - Wireless Nodes Database
 * Modern layout body
 *}
<div class="layout">
        {if $header != ''}
        <div class="header">{$header}</div>
        {/if}
        {if $menu != ''}
        <div class="navigation">{$menu}</div>
        {/if}
        <div class="main">
                {if $message==''}
                        {$center}
                {else}
                        <div style="padding: 28px;">
                                <div class="message">{$message}</div>
                        </div>
                {/if}
        </div>
        {if $footer != ''}
        <footer class="footer">
                {$footer}
        </footer>
        {/if}
</div>
