using CatalogService as service from '../../srv/cat-service';

// =============================================================
// BOOKS - ANALYTICAL LIST PAGE ANNOTATIONS
// =============================================================

// ---------------------------------------------------------
// AGGREGATION: Marks the entity as aggregatable
// Enables the ALP to group and aggregate data server-side
// ---------------------------------------------------------
annotate service.books with @(
    Aggregation.ApplySupported : {
        Transformations          : [
            'aggregate',
            'topcount',
            'bottomcount',
            'identity',
            'concat',
            'groupby',
            'filter',
            'top',
            'skip',
            'orderby',
            'search'
        ],
        GroupableProperties      : [
            GENRE,
            AUTHOR,
            PUBLISHED_YEAR
        ],
        AggregatableProperties   : [
            {Property : PRICE},
        ],
    },
    Analytics.AggregatedProperty #totalPrice : {
        Name                 : 'totalPrice',
        AggregationMethod    : 'sum',
        AggregatableProperty : PRICE,
        ![@Common.Label]     : 'Total Price',
    },
    Analytics.AggregatedProperty #avgPrice : {
        Name                 : 'avgPrice',
        AggregationMethod    : 'average',
        AggregatableProperty : PRICE,
        ![@Common.Label]     : 'Average Price',
    },
    Analytics.AggregatedProperty #bookCount : {
        Name                 : 'bookCount',
        AggregationMethod    : 'countdistinct',
        AggregatableProperty : ID,
        ![@Common.Label]     : 'Number of Books',
    },
);

annotate service.books with @(

    // ---------------------------------------------------------
    // HEADER INFO
    // ---------------------------------------------------------
    UI.HeaderInfo : {
        TypeName       : 'Book',
        TypeNamePlural : 'Books',
        Title          : {
            $Type : 'UI.DataField',
            Value : TITLE,
        },
        Description    : {
            $Type : 'UI.DataField',
            Value : AUTHOR,
        },
    },

    // ---------------------------------------------------------
    // SELECTION FIELDS: Filters on the ALP filter bar
    // ---------------------------------------------------------
    UI.SelectionFields : [
        GENRE,
        AUTHOR,
        PUBLISHED_YEAR,
    ],

    // ---------------------------------------------------------
    // LINE ITEM: Columns in the ALP table
    // ---------------------------------------------------------
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Book ID',
            Value : ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Title',
            Value : TITLE,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Author',
            Value : AUTHOR,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Published Year',
            Value : PUBLISHED_YEAR,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Genre',
            Value : GENRE,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Price',
            Value : PRICE,
        },
    ],

    // ---------------------------------------------------------
    // PRESENTATION VARIANT: Default grouping and sorting for ALP
    // Groups by Genre, sorted by Price descending
    // Includes both Chart and Table visualizations
    // ---------------------------------------------------------
    UI.PresentationVariant : {
        Text           : 'Default',
        SortOrder      : [{
            Property   : PRICE,
            Descending : true,
        }],
        GroupBy        : [GENRE],
        Visualizations : [
            '@UI.Chart',
            '@UI.LineItem',
        ],
    },

    // ---------------------------------------------------------
    // SELECTION VARIANT: Default filter for ALP
    // ---------------------------------------------------------
    UI.SelectionVariant #Default : {
        Text             : 'Default',
        SelectOptions    : [],
    },

    // ---------------------------------------------------------
    // CHART: Bar chart showing Total Price by Genre
    // Uses DynamicMeasures referencing Analytics.AggregatedProperty
    // ---------------------------------------------------------
    UI.Chart : {
        Title                 : 'Books by Genre',
        ChartType             : #Bar,
        Dimensions            : [GENRE],
        DimensionAttributes   : [{
            Dimension : GENRE,
            Role      : #Category,
        }],
        DynamicMeasures       : [
            '@Analytics.AggregatedProperty#totalPrice',
            '@Analytics.AggregatedProperty#avgPrice',
        ],
        MeasureAttributes     : [{
            $Type          : 'UI.ChartMeasureAttributeType',
            DynamicMeasure : '@Analytics.AggregatedProperty#totalPrice',
            Role           : #Axis1,
        }],
    },

    // ---------------------------------------------------------
    // FIELD GROUP: Book Details section on Object Page
    // ---------------------------------------------------------
    UI.FieldGroup #BookDetails : {
        $Type : 'UI.FieldGroupType',
        Label : 'Book Details',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : 'Book ID',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Title',
                Value : TITLE,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Author',
                Value : AUTHOR,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Published Year',
                Value : PUBLISHED_YEAR,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Genre',
                Value : GENRE,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Price',
                Value : PRICE,
            },
        ],
    },

    // ---------------------------------------------------------
    // FACETS: Object Page sections
    // ---------------------------------------------------------
    UI.Facets : [{
        $Type  : 'UI.ReferenceFacet',
        ID     : 'BookDetailsFacet',
        Label  : 'Book Details',
        Target : '@UI.FieldGroup#BookDetails',
    }],

);

// ---------------------------------------------------------
// FIELD LABELS
// ---------------------------------------------------------
annotate service.books with {
    ID             @title : 'Book ID';
    TITLE          @title : 'Title';
    AUTHOR         @title : 'Author';
    PUBLISHED_YEAR @title : 'Published Year';
    GENRE          @title : 'Genre';
    PRICE          @title : 'Price';
};

// ---------------------------------------------------------
// MEASURES & DIMENSIONS: Mark fields for ALP analytics
// ---------------------------------------------------------
annotate service.books with {
    PRICE          @Aggregation.default : #SUM;
    GENRE          @Analytics.Dimension : true;
    AUTHOR         @Analytics.Dimension : true;
    PUBLISHED_YEAR @Analytics.Dimension : true;
    ID             @Analytics.Dimension : true;
};