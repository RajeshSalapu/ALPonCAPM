sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'booksanalytics',
            componentId: 'booksList',
            contextPath: '/books'
        },
        CustomPageDefinitions
    );
});