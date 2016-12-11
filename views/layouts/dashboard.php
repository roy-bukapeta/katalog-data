<?php

/* @var $this \yii\web\View */
/* @var $content string */
use yii\helpers\Url;
// use yii\helpers\Html;
use macgyer\yii2materializecss\lib\Html;
// use yii\bootstrap\Nav;
// use yii\bootstrap\NavBar;
// use yii\widgets\Breadcrumbs;
use macgyer\yii2materializecss\widgets\Nav;
use macgyer\yii2materializecss\widgets\NavBar;
use macgyer\yii2materializecss\widgets\Breadcrumbs;
use app\assets\AppAsset;
use kartik\widgets\SideNav;
use mdm\admin\components\Helper;


$this->title = 'TEMPLATE';

AppAsset::register($this);
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
<head>
    <meta charset="<?= Yii::$app->charset ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?= Html::csrfMetaTags() ?>
    <title><?= Html::encode($this->title) ?></title>
    <?php $this->head() ?>
</head>
<style type="text/css">
    .breadcrumb {
        background-color: #ee6e73 !important;
    }
</style>
<body>
<?php $this->beginBody() ?>
<div class="wrap">
    <?php
    NavBar::begin([
        'brandLabel' => 'Katalog Data',
        'options' => [
            'class' => 'navbar-fixed-top',
            'style' => 'padding: 0px 20px 0px 20px;'
        ],
    ]);
    echo Nav::widget([
        'options' => ['class' => 'navbar-nav navbar-right','innerContainerOptions' => ['class'=>'container-fluid']],
        'encodeLabels' => false,
        'items' => [
            ['label' => 'Home', 'url' => ['/site/index']],
            // ['label' => 'About', 'url' => ['/site/about']],
            // ['label' => 'Contact', 'url' => ['/site/contact']],
            ['label' => 'Dashboard', 'url' => ['/dashboard/index'], 'visible' => !Yii::$app->user->isGuest],
            Yii::$app->user->isGuest ?
            ['label' => 'Sign in', 'url' => ['/user/security/login']] :
            ['label' => 'Sign out (' . Yii::$app->user->identity->username . ')',
                'url' => ['/user/security/logout'],
                'linkOptions' => ['data-method' => 'post']
            ],
        ],
    ]);
    NavBar::end();
    ?>

    <div class="container">
        <?= Breadcrumbs::widget([
            'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
        ]) ?><br>

        <?php if ( Url::current() !== '/web/user/login' && Url::current() !== '/web/user/register' && Url::current() !== '/web/user/settings/account' && Url::current() !== '/web/user/settings/profile' &&  Url::current() !== '/web/user/forgot' && Url::current() !== '/web/user/resend') { ?>  <!-- Tidak Menampilkan sidebar pada menu login dan register -->
            <div class="row">
                <div class="col-md-3">
                   <?php
                        if (Yii::$app->user->isGuest) {

                            echo "";
                        }else{ 

                        $menuSidebar = [
                            [
                                'url' => ['/dashboard/index/'],
                                'label' => Yii::t('app','Dashboard'),
                                'icon' => 'cog',
                                'active' => (Yii::$app->controller->id === 'dashboard')
                            ],
                        ];
    

                        $menuSidebar[] = [
                            'url' => ['/user/admin'],
                            'label' => Yii::t('app','User'),
                            'icon' => 'user',
                            'active' => (Yii::$app->controller->id === 'admin' || Yii::$app->controller->id === 'id')
                        ];

                        $menuSidebar[] = [
                            'label' => 'RBAC',
                            'icon' => 'transfer',
                            'items' => [
                                [
                                    'label' => Yii::t('app','Assignment'),
                                    'icon'=>'hand-right',
                                    'url'=>['/admin/assignment'],
                                    'active' => (Yii::$app->controller->id === 'assignment')
                                ],
                                [
                                    'label' => Yii::t('app','Role'),
                                    'icon'=>'pushpin',
                                    'url'=>['/admin/role'],
                                    'active' => (Url::current() === '/web/admin/role/index')
                                ],
                                [
                                    'label' => Yii::t('app','Permission'),
                                    'icon'=>'bookmark',
                                    'url'=>['/admin/permission'],
                                    'active' => (Yii::$app->controller->id === 'permission')
                                ],
                                [
                                    'label' => Yii::t('app','Rute'),
                                    'icon'=>'share-alt',
                                    'url'=>['/admin/route'],
                                    'active' => (Yii::$app->controller->id === 'route')
                                ],
                                [
                                    'label' => Yii::t('app','Rules'),
                                    'icon'=>'tasks',
                                    'url'=>['/admin/rule'],
                                    'active' => (Yii::$app->controller->id === 'rule')
                                ],

                                // [
                                //     'label' => Yii::t('app','Menu'),
                                //     'icon'=>'menu-hamburger',
                                //     'url'=>['/admin/menu'],
                                //     'active' => (Yii::$app->controller->id === 'menu')
                                // ],
                            ],
                        ];
                        //$menuSidebar = Helper::filter($menuSidebar);
                        echo SideNav::widget([
                            'type' => SideNav::TYPE_DEFAULT,
                            'encodeLabels' => false,
                            'heading' => Yii::t('app','Dashboard'),
                            'items' => $menuSidebar
                        ]);
                    }
                    ?>
                </div>
    
                <div class="col-md-9">
                    <?= $content ?>
                </div>
            </div>
        <?php } else { ?>
            <?= $content ?>
        <?php } ?>

    </div>
</div>

<footer class="footer">
    <div class="container">
        <center><p>&copy; Katalog Data <?= date('Y') ?></p></center>
    </div>
</footer>

<?php $this->endBody() ?>
</body>
</html>
<?php $this->endPage() ?>
