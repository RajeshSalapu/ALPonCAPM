sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"booksanalytics/test/integration/pages/booksList",
	"booksanalytics/test/integration/pages/booksObjectPage"
], function (JourneyRunner, booksList, booksObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('booksanalytics') + '/test/flpSandbox.html#booksanalytics-tile',
        pages: {
			onThebooksList: booksList,
			onThebooksObjectPage: booksObjectPage
        },
        async: true
    });

    return runner;
});

