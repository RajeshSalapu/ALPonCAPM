sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/project2/test/integration/pages/studentList",
	"com/project2/test/integration/pages/studentObjectPage"
], function (JourneyRunner, studentList, studentObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/project2') + '/test/flp.html#app-preview',
        pages: {
			onThestudentList: studentList,
			onThestudentObjectPage: studentObjectPage
        },
        async: true
    });

    return runner;
});

