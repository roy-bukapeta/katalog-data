<?php
/**
 * @link https://github.com/MacGyer/yii2-materializecss
 * @copyright Copyright (c) 2016 ... MacGyer for pluspunkt coding
 * @license https://github.com/MacGyer/yii2-materializecss/blob/master/LICENSE
 */

namespace macgyer\yii2materializecss\widgets\grid;

/**
 * The GridView widget is used to display data in a grid.
 *
 * It provides features like sorting, paging and also filtering the data.
 *
 * A basic usage looks like the following:
 *
 * ```php
 * <?= GridView::widget([
 *     'dataProvider' => $dataProvider,
 *     'columns' => [
 *         'id',
 *         'name',
 *         'created_at:datetime',
 *         // ...
 *     ],
 * ]) ?>
 * ```
 *
 * The columns of the grid table are configured in terms of [yii\grid\Column](http://www.yiiframework.com/doc-2.0/yii-grid-column.html) classes,
 * which are configured via [yii\grid\GridView::$columns](http://www.yiiframework.com/doc-2.0/yii-grid-gridview.html#$columns-detail).
 *
 * The look and feel of a grid view can be customized using the large amount of properties.
 * 
 * @author Christoph Erdmann <yii2-materializecss@pluspunkt-coding.de>
 * @package widgets
 * @subpackage grid
 */
class GridView extends \yii\grid\GridView
{
    /**
     * @var array the HTML attributes for the grid table element.
     * @see [yii\helpers\BaseHtml::renderTagAttributes()](http://www.yiiframework.com/doc-2.0/yii-helpers-basehtml.html#renderTagAttributes()-detail) for details on 
     * how attributes are being rendered.
     */
    public $tableOptions = ['class' => 'table striped bordered'];
}
