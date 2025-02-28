<form name="categories" action="" method="post" id="categories_move" onSubmit="return moveCategory();">

    <div class="popup-heading">
        {$smarty.const.TEXT_INFO_HEADING_MOVE_CATEGORY}
    </div>
    <div class="popup-content">

        <div class="row mb-3">
            <div class="col-12">
                {sprintf($smarty.const.TEXT_MOVE, $cInfo->categories_name)}
            </div>
        </div>


        <div class="mb-3" style="height: 360px">
            <select name="move_to_category_id" class="form-control categories-select">
                {foreach \common\helpers\Categories::get_category_tree(0, '', '', '', false, true) as $item}
                    <option value="{$item.id}">{$item.text}</option>
                {/foreach}
            </select>
        </div>

    </div>
    <div class="popup-buttons">
        <button class="btn btn-cancel" onClick="return resetStatement()">{$smarty.const.IMAGE_CANCEL}</button>
        <button class="btn btn-move btn-confirm">{$smarty.const.IMAGE_MOVE}</button>
        <input type="hidden" name="categories_id" value="{$cInfo->categories_id}">
    </div>

</form>
<script type="text/javascript">
    (function($){
        $('.categories-select').multipleSelect({
            filter: true,
            place:'{$smarty.const.TEXT_SEARCH_ITEMS}',
            isOpen: true,
            keepOpen: true,
            maxHeight: 300,
            selectAll: false,
            data: [
                {foreach \common\helpers\Categories::get_category_tree(0, '', '', '', false, true) as $item}
                {
                    text: wrapCategory('{$item.text}'),
                    value: '{$item.id}',
                },
                {/foreach}
            ],
            onFilter: function (t) {
                if (t) {
                    $('.categories-select').addClass('searching')
                } else {
                    $('.categories-select').removeClass('searching')
                }
            }
        });

        function wrapCategory(str) {
            let lastIndex = str.lastIndexOf("&nbsp;&nbsp;&gt;&nbsp;&nbsp;");

            if (lastIndex !== -1) {
                lastIndex = lastIndex + 28;
                const startCategory = str.substring(0, lastIndex);
                const endCategory = str.substring(lastIndex);

                return `<span class="in-category">${ startCategory}</span>${ endCategory}`.replaceAll('&nbsp;', '<span class="nbsp">&nbsp;</span>');
            }

            return str;
        }

        $('.copy-as').on('click', function() {
            if ($(this).val() == 'duplicate') {
                $('#copy_dup_selected').show();
            } else {
                $('#copy_dup_selected').hide();
            }
        });
    })(jQuery);
</script>