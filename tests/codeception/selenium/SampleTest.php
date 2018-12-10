<?php

class SampleTest extends \Codeception\Test\Unit
{
    /**
     * @var \SeleniumTester
     */
    protected $tester;


    public function testGoogleLandingPage()
    {
        $this->tester->amOnUrl('https://google.com');

        $this->tester->canSee('Google');
    }

}
