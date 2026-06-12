namespace imNamespace;

using {
  cuid,
  managed,
  temporal
} from '@sap/cds/common';
using {imNamespace.commons as commons} from './commons';
using { Attachments } from '@cap-js/attachments';


entity student : commons.ADDRESS {
  key ID          : String;
      NAME        : String;
      CLASS       : Association to one standards;
      GENDER      : String(1);
      AGE         : Integer;
      // Attachments composition - enables file upload/download on the Object Page
      attachments : Composition of many Attachments;
}

entity books {
  key ID             : String;
      TITLE          : String;
      AUTHOR         : String;
      PUBLISHED_YEAR : Integer;
      GENRE          : String;
      PRICE          : Decimal(10, 2);
}

entity standards {
  key ID           : String;
      CLASSNAME    : String;
      SECTION      : String;
      CLASSTEACHER : String;
}

entity rentals : cuid, temporal {
  STUDENT : Association to one student;
  items   : Composition of many rentalItems
              on items.rental = $self;
}

entity rentalItems : cuid {
  rental : Association to one rentals;
  BOOK   : Association to one books;
}
