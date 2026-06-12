using CatalogService as service from '../../srv/cat-service';

// =============================================================
// STUDENT LIST PAGE & OBJECT PAGE ANNOTATIONS
// =============================================================

annotate service.student with @(

    // ---------------------------------------------------------
    // HEADER INFO: Shown at the top of the Object Page
    // Displays Student Name as the title and Class ID as subtitle
    // ---------------------------------------------------------
    UI.HeaderInfo : {
        TypeName       : 'Student',
        TypeNamePlural : 'Students',
        Title          : {
            $Type : 'UI.DataField',
            Value : NAME,
        },
        Description    : {
            $Type : 'UI.DataField',
            Value : CLASS_ID,
        },
    },

    // ---------------------------------------------------------
    // SELECTION FIELDS: Filters shown on the List Report page
    // Users can filter students by Class ID, Class Name, and Section
    // ---------------------------------------------------------
    UI.SelectionFields : [
        CLASS_ID,           // Filter by Class ID
        CLASS.CLASSNAME,    // Filter by Class Name (navigating via association)
        CLASS.SECTION,      // Filter by Section (navigating via association)
    ],

    // ---------------------------------------------------------
    // LINE ITEM: Columns shown in the List Report table
    // ---------------------------------------------------------
    UI.LineItem : [
        {
            // Student ID column
            $Type : 'UI.DataField',
            Label : 'Student ID',
            Value : ID,
        },
        {
            // Student Full Name column
            $Type : 'UI.DataField',
            Label : 'Student Name',
            Value : NAME,
        },
        {
            // Gender column
            $Type : 'UI.DataField',
            Label : 'Gender',
            Value : GENDER,
        },
        {
            // Age column
            $Type : 'UI.DataField',
            Label : 'Age',
            Value : AGE,
        },
        {
            // Class ID column - linked to the standards entity via association
            $Type : 'UI.DataField',
            Label : 'Class ID',
            Value : CLASS_ID,
        },
        {
            // Class Name - fetched from associated standards entity
            $Type : 'UI.DataField',
            Label : 'Class Name',
            Value : CLASS.CLASSNAME,
        },
        {
            // Section - fetched from associated standards entity
            $Type : 'UI.DataField',
            Label : 'Section',
            Value : CLASS.SECTION,
        },
        {
            // Street address column
            $Type : 'UI.DataField',
            Label : 'Street',
            Value : street,
        },
        {
            // City column
            $Type : 'UI.DataField',
            Label : 'City',
            Value : city,
        },
    ],

    // ---------------------------------------------------------
    // FIELD GROUP: Groups fields together in the Object Page
    // "Personal Details" section - basic student information
    // ---------------------------------------------------------
    UI.FieldGroup #PersonalDetails : {
        $Type : 'UI.FieldGroupType',
        Label : 'Personal Details',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : 'Student ID',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Full Name',
                Value : NAME,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Gender',
                Value : GENDER,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Age',
                Value : AGE,
            },
        ],
    },

    // ---------------------------------------------------------
    // FIELD GROUP: "Class Information" section
    // Shows the class the student belongs to with details from standards
    // ---------------------------------------------------------
    UI.FieldGroup #ClassInformation : {
        $Type : 'UI.FieldGroupType',
        Label : 'Class Information',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : 'Class ID',
                Value : CLASS_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Class Name',
                Value : CLASS.CLASSNAME,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Section',
                Value : CLASS.SECTION,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Class Teacher',
                Value : CLASS.CLASSTEACHER,
            },
        ],
    },

    // ---------------------------------------------------------
    // FIELD GROUP: "Address Details" section
    // Contains address-related fields from commons.ADDRESS
    // ---------------------------------------------------------
    UI.FieldGroup #AddressDetails : {
        $Type : 'UI.FieldGroupType',
        Label : 'Address Details',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : 'Street',
                Value : street,
            },
            {
                $Type : 'UI.DataField',
                Label : 'City',
                Value : city,
            },
            {
                $Type : 'UI.DataField',
                Label : 'State',
                Value : state,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Postal Code',
                Value : postalCode,
            },
        ],
    },

    // ---------------------------------------------------------
    // FACETS: Sections/Tabs shown on the Object Page
    // Each facet maps to a FieldGroup defined above
    // ---------------------------------------------------------
    UI.Facets : [
        {
            // Tab 1: Personal Details
            $Type  : 'UI.ReferenceFacet',
            ID     : 'PersonalDetailsFacet',
            Label  : 'Personal Details',
            Target : '@UI.FieldGroup#PersonalDetails',
        },
        {
            // Tab 2: Class Information
            $Type  : 'UI.ReferenceFacet',
            ID     : 'ClassInformationFacet',
            Label  : 'Class Information',
            Target : '@UI.FieldGroup#ClassInformation',
        },
        {
            // Tab 3: Address Details
            $Type  : 'UI.ReferenceFacet',
            ID     : 'AddressDetailsFacet',
            Label  : 'Address Details',
            Target : '@UI.FieldGroup#AddressDetails',
        },
        {
            // Tab 4: Attachments - File upload/download section
            // Uses the built-in Fiori Elements attachment component
            // powered by @cap-js/attachments plugin
            $Type  : 'UI.ReferenceFacet',
            ID     : 'AttachmentsFacet',
            Label  : 'Attachments',
            Target : 'attachments/@UI.LineItem',
        },
    ],

    // ---------------------------------------------------------
    // CREATE / DELETE CAPABILITIES
    // Enables "Create" button on List Report and "Delete" button
    // on Object Page. "Deletable" and "Insertable" are set to true.
    // ---------------------------------------------------------
    Capabilities.InsertRestrictions : {
        // Allows creating new student records
        Insertable : true,
    },
    Capabilities.DeleteRestrictions : {
        // Allows deleting existing student records
        Deletable  : true,
    },
    Capabilities.UpdateRestrictions : {
        // Allows editing/updating student records (needed for Draft)
        Updatable  : true,
    },

);

// =============================================================
// VALUE HELP (VALUE LIST) ANNOTATIONS
// Defines F4 help popups for CLASS_ID, CLASSNAME, and SECTION
// All three look up data from the 'standards' entity
// =============================================================
annotate service.student with {

    // ---------------------------------------------------------
    // VALUE HELP for CLASS field (CLASS_ID)
    // When user clicks on Class ID field, a popup shows all
    // available classes. Selecting a row fills in the CLASS_ID.
    // ---------------------------------------------------------
    CLASS @(
        Common.Label : 'Class',

        Common.ValueList : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'standards',
            Parameters     : [
                {
                    // Writes the selected Class ID back into CLASS_ID field
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : CLASS_ID,
                    ValueListProperty : 'ID',
                },
                {
                    // Displays Class Name in the popup (read-only)
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'CLASSNAME',
                },
                {
                    // Displays Section in the popup (read-only)
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'SECTION',
                },
                {
                    // Displays Class Teacher in the popup (read-only)
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'CLASSTEACHER',
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
    )
};

// ---------------------------------------------------------
// VALUE HELP for CLASSNAME filter field
// When user types/clicks in the Class Name filter on the
// List Report, a popup shows all class names from standards.
// Selecting a row fills in both CLASSNAME and CLASS_ID.
// ---------------------------------------------------------
annotate service.standards with {
    CLASSNAME @(
        Common.Label : 'Class Name',

        Common.ValueList : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'standards',
            Parameters     : [
                {
                    // Writes selected Class Name back into the CLASSNAME filter field
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : CLASSNAME,
                    ValueListProperty : 'CLASSNAME',
                },
                {
                    // Also shows the Class ID in the popup for reference
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ID',
                },
                {
                    // Also shows the Section in the popup for reference
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'SECTION',
                },
                {
                    // Also shows the Class Teacher in the popup for reference
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'CLASSTEACHER',
                },
            ],
        },
        // Free-text search allowed (not restricted to fixed values)
        Common.ValueListWithFixedValues : false,
    );

    // ---------------------------------------------------------
    // VALUE HELP for SECTION filter field
    // When user types/clicks in the Section filter on the
    // List Report, a popup shows all sections from standards.
    // Selecting a row fills in the SECTION filter field.
    // ---------------------------------------------------------
    SECTION @(
        Common.Label : 'Section',

        Common.ValueList : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'standards',
            Parameters     : [
                {
                    // Writes selected Section back into the SECTION filter field
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : SECTION,
                    ValueListProperty : 'SECTION',
                },
                {
                    // Also shows the Class ID in the popup for reference
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ID',
                },
                {
                    // Also shows the Class Name in the popup for reference
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'CLASSNAME',
                },
                {
                    // Also shows the Class Teacher in the popup for reference
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'CLASSTEACHER',
                },
            ],
        },
        // Free-text search allowed (not restricted to fixed values)
        Common.ValueListWithFixedValues : false,
    );
};

// =============================================================
// FIELD LABELS: Human-readable labels for student fields
// These appear as column headers, form labels, and filter labels
// =============================================================
annotate service.student with {
    ID         @title : 'Student ID';
    NAME       @title : 'Student Name';
    GENDER     @title : 'Gender';
    AGE        @title : 'Age';
    CLASS_ID   @title : 'Class ID';
    street     @title : 'Street';
    city       @title : 'City';
    state      @title : 'State';
    postalCode @title : 'Postal Code';
};

