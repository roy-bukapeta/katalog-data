<?php

namespace app\controllers;

class DashboardController extends \yii\web\Controller
{
    public function actionIndex()
    {
        $this->layout = 'dashboard';
        return $this->render('index');
    }

}
