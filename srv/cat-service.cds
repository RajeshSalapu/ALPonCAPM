using imNamespace as my from '../db/schema';

service CatalogService {
    // Student entity - Draft enabled for create, edit and delete support
    @odata.draft.enabled
    entity student as projection on my.student;
    @readonly entity books as projection on my.books;
    @readonly entity standards as projection on my.standards;
    entity rentals as projection on my.rentals;
    @readonly entity rentalItems as projection on my.rentalItems;
}
