CLASS zcl_abap_mustache_3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun. " to run the class in Console

    TYPES: BEGIN OF gty_book_details,
             book_name TYPE string,
             genre     TYPE string,
             author    TYPE string,
             year      TYPE string,
           END OF gty_book_details,
           gtty_book_det TYPE STANDARD TABLE OF gty_book_details WITH DEFAULT KEY,

           BEGIN OF gty_books,
             book_lib TYPE string,
             book_det TYPE gtty_book_det,
           END OF gty_books,

           gtty_books TYPE STANDARD TABLE OF gty_books WITH DEFAULT KEY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_mustache_3 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


    DATA(lt_books) = VALUE gtty_books( ( book_lib = 'SAP Book Library'  book_det = VALUE gtty_book_det(
                                                          ( book_name = 'The Autobiography of Benjamin Franklin'
                                                            genre = 'Autobiography'
                                                            author = 'Benjamin Franklin'
                                                            year = '1971'
                                                            )
                                                            ( book_name = 'Long Walk to Freedom'
                                                              genre = 'Autobiography'
                                                              author = 'Nelson Mandela'
                                                              year = '1994'
                                                              )

                                                            ( book_name = 'The Glass Castle'
                                                              genre = 'Autobiography'
                                                              author = 'Jeannette Walls'
                                                              year = '2005'
                                                             )

                                                            ( book_name = 'The Martian'
                                                            author = 'Andy Weir'
                                                            genre = 'Science fiction'
                                                             year = '2011'
                                                            )
                                                            ( book_name = `Ender's Game`
                                                              author = 'Orson Scott Card'
                                                              genre = 'Science fiction'
                                                              year = '1985'
                                                            )
                                                            ( book_name = 'Fahrenheit 451'
                                                              genre = 'Science fiction'
                                                              author = 'Ray Bradbury'
                                                              year = '1953'
                                                              )
                                                            ( book_name = 'Big Little Lies'
                                                            genre = 'Mystery'
                                                            author = 'Liane Moriarty'
                                                             year = '2014'
                                                            )
                                                            ( book_name = 'The Girl on the Train'
                                                            genre = 'Mystery'
                                                                    author = 'Paula Hawkins'
                                                                    year = '2015'
                                                              )
                                                              ( book_name = 'The Rising Tide'
                                                                genre = 'Mystery'
                                                                    author = 'Ann Cleeves'
                                                                    year = '2022'
                                                              )
                                                              ) ) ).



    TRY.
        DATA(lo_mustache) = zcl_mustache=>create(

                                'Welcome to {{book_lib}} !' && cl_abap_char_utilities=>newline &&
                                  ' {{#book_det}}' && cl_abap_char_utilities=>newline &&
                                  ' Name: {{book_name}} -- Genre: {{genre}} -- Author :{{author}} -- Published Year: {{year}}' && cl_abap_char_utilities=>newline &&
                                  ' {{/book_det}}'
                            ).

        out->write( lo_mustache->render( lt_books ) ).
      CATCH zcx_mustache_error INTO DATA(lx_error).
        "handle exception
    ENDTRY.

  ENDMETHOD.


ENDCLASS.
