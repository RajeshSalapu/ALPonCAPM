sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/project1/test/integration/pages/studentMain"
], function (JourneyRunner, studentMain) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/project1') + '/test/flp.html#app-preview',
        pages: {
			onThestudentMain: studentMain
        },
        async: true
    });

    return runner;
});

