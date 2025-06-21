class ZCL_SCR definition
  public
  final
  create public .

public section.

  data:
*"* public components of class ZCL_SCR
*"* do not include other source files here!!!
    t_screen type table of screen read-only .

  methods APPLY_CHANGES .
  methods CONSTRUCTOR .
  methods FIELD_ACTIVE
    importing
      !FIELDNAME type CLIKE
      !STATE type ABAP_BOOL default ABAP_TRUE .
  methods FIELD_ACTIVE_OFF
    importing
      !FIELDNAME type CLIKE .
  methods FIELD_ACTIVE_ON
    importing
      !FIELDNAME type CLIKE .
  methods FIELD_HIDE
    importing
      !FIELDNAME type CLIKE .
  methods FIELD_INPUT
    importing
      !FIELDNAME type CLIKE
      !STATE type ABAP_BOOL default ABAP_TRUE .
  methods FIELD_INPUT_OFF
    importing
      !FIELDNAME type CLIKE .
  methods FIELD_INPUT_ON
    importing
      !FIELDNAME type CLIKE .
  methods FIELD_REQUIRED
    importing
      !FIELDNAME type CLIKE
      !STATE type ABAP_BOOL default ABAP_TRUE .
  methods FIELD_REQUIRED_OFF
    importing
      !FIELDNAME type CLIKE .
  methods FIELD_REQUIRED_ON
    importing
      !FIELDNAME type CLIKE .
  methods FIELD_SHOW
    importing
      !FIELDNAME type CLIKE .
  methods FIELD_VISIBLE
    importing
      !FIELDNAME type CLIKE
      !STATE type ABAP_BOOL default ABAP_TRUE .
  methods GROUP_ACTIVE
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional
      !STATE type ABAP_BOOL default ABAP_TRUE .
  methods GROUP_ACTIVE_OFF
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional .
  methods GROUP_ACTIVE_ON
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional .
  methods GROUP_HIDE
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional .
  methods GROUP_INPUT
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional
      !STATE type ABAP_BOOL default ABAP_TRUE .
  methods GROUP_INPUT_OFF
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional .
  methods GROUP_INPUT_ON
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional .
  methods GROUP_REQUIRED
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional
      !STATE type ABAP_BOOL default ABAP_TRUE .
  methods GROUP_REQUIRED_OFF
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional .
  methods GROUP_REQUIRED_ON
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional .
  methods GROUP_SHOW
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional .
  methods GROUP_VISIBLE
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional
      !STATE type ABAP_BOOL default ABAP_TRUE .
  methods REFRESH .
  methods SET_FIELD_ATRIB
    importing
      !FIELDNAME type CLIKE
      !ATRIB type CLIKE
      !VALUE type ANY .
  methods SET_FIELD_PREFIX
    importing
      !FIELD_PREFIX type CLIKE .
  methods SET_GROUP_ATRIB
    importing
      !GROUP1 type SCREEN-GROUP1 optional
      !GROUP2 type SCREEN-GROUP2 optional
      !GROUP3 type SCREEN-GROUP3 optional
      !GROUP4 type SCREEN-GROUP4 optional
      !GROUPNR type CLIKE optional
      !ATRIB type CLIKE
      !VALUE type ANY .
  methods SET_CURSOR_FIELD
    importing
      !FIELDNAME type CLIKE .
  methods SET_CURSOR
    importing
      !FIELDNAME type CLIKE .
  protected section.

*"* protected components of class ZCL_SCR
*"* do not include other source files here!!!
    data v_field_prefix type string .
    data v_cursor type scrfname .
  private section.
*"* private components of class ZCL_SCR
*"* do not include other source files here!!!
ENDCLASS.



CLASS ZCL_SCR IMPLEMENTATION.


  method apply_changes.
    field-symbols: <ls_screen> like line of me->t_screen.
    loop at screen.
      read table me->t_screen with key name = screen-name assigning <ls_screen>.
      if sy-subrc = 0.
        screen = <ls_screen>.
        modify screen.
      endif.
    endloop.
    if v_cursor is not initial.
      set cursor field v_cursor.
    endif.
  endmethod.


  method constructor.
    refresh( ).
  endmethod.


  method field_active.
    if state eq abap_true.
      field_active_on( fieldname ).
    else.
      field_active_off( fieldname ).
    endif.
  endmethod.


  method field_active_off.
    set_field_atrib( fieldname = fieldname atrib = 'ACTIVE' value = '0' ).
  endmethod.


  method field_active_on.
    set_field_atrib( fieldname = fieldname atrib = 'ACTIVE' value = '1' ).
  endmethod.


  method field_hide.
    set_field_atrib( fieldname = fieldname atrib = 'INVISIBLE' value = '1' ).
  endmethod.


  method field_input.
    if state eq abap_true.
      field_input_on( fieldname ).
    else.
      field_input_off( fieldname ).
    endif.
  endmethod.


  method field_input_off.
    set_field_atrib( fieldname = fieldname atrib = 'INPUT' value = '0' ).
  endmethod.


  method field_input_on.
    set_field_atrib( fieldname = fieldname atrib = 'INPUT' value = '1' ).
  endmethod.


  method field_required.
    if state eq abap_true.
      field_required_on( fieldname ).
    else.
      field_required_off( fieldname ).
    endif.
  endmethod.


  method field_required_off.
    set_field_atrib( fieldname = fieldname atrib = 'REQUIRED' value = '0' ).
  endmethod.


  method field_required_on.
    set_field_atrib( fieldname = fieldname atrib = 'REQUIRED' value = '1' ).
  endmethod.


  method field_show.
    set_field_atrib( fieldname = fieldname atrib = 'INVISIBLE' value = '0' ).
  endmethod.


  method field_visible.
    if state eq abap_true.
      field_show( fieldname ).
    else.
      field_hide( fieldname ).
    endif.
  endmethod.


  method group_active.
    if state eq abap_true.
      group_active_on( group1  = group1
                       group2  = group2
                       group3  = group3
                       group4  = group4
                       groupnr = groupnr ).
    else.
      group_active_off( group1  = group1
                        group2  = group2
                        group3  = group3
                        group4  = group4
                        groupnr = groupnr ).
    endif.
  endmethod.


  method group_active_off.
    set_group_atrib( group1  = group1
                     group2  = group2
                     group3  = group3
                     group4  = group4
                     groupnr = groupnr
                     atrib = 'ACTIVE'
                     value = '0' ).
  endmethod.


  method group_active_on.
    set_group_atrib( group1  = group1
                     group2  = group2
                     group3  = group3
                     group4  = group4
                     groupnr = groupnr
                     atrib = 'ACTIVE'
                     value = '1' ).
  endmethod.


  method group_hide.
    set_group_atrib( group1  = group1
                     group2  = group2
                     group3  = group3
                     group4  = group4
                     groupnr = groupnr
                     atrib = 'INVISIBLE'
                     value = '1' ).
  endmethod.


  method group_input.
    if state eq abap_true.
      group_input_on( group1  = group1
                      group2  = group2
                      group3  = group3
                      group4  = group4
                      groupnr = groupnr ).
    else.
      group_input_off( group1  = group1
                       group2  = group2
                       group3  = group3
                       group4  = group4
                       groupnr = groupnr ).
    endif.
  endmethod.


  method group_input_off.
    set_group_atrib( group1  = group1
                     group2  = group2
                     group3  = group3
                     group4  = group4
                     groupnr = groupnr
                     atrib = 'INPUT'
                     value = '0' ).
  endmethod.


  method group_input_on.
    set_group_atrib( group1  = group1
                     group2  = group2
                     group3  = group3
                     group4  = group4
                     groupnr = groupnr
                     atrib = 'INPUT'
                     value = '1' ).
  endmethod.


  method group_required.
    if state eq abap_true.
      group_required_on( group1  = group1
                         group2  = group2
                         group3  = group3
                         group4  = group4
                         groupnr = groupnr ).
    else.
      group_required_off( group1  = group1
                          group2  = group2
                          group3  = group3
                          group4  = group4
                          groupnr = groupnr ).
    endif.
  endmethod.


  method group_required_off.
    set_group_atrib( group1  = group1
                     group2  = group2
                     group3  = group3
                     group4  = group4
                     groupnr = groupnr
                     atrib = 'REQUIRED'
                     value = '0' ).
  endmethod.


  method group_required_on.
    set_group_atrib( group1  = group1
                     group2  = group2
                     group3  = group3
                     group4  = group4
                     groupnr = groupnr
                     atrib = 'REQUIRED'
                     value = '1' ).
  endmethod.


  method group_show.
    set_group_atrib( group1  = group1
                     group2  = group2
                     group3  = group3
                     group4  = group4
                     groupnr = groupnr
                     atrib = 'INVISIBLE'
                     value = '0' ).
  endmethod.


  method group_visible.
    if state eq abap_true.
      group_show( group1  = group1
                  group2  = group2
                  group3  = group3
                  group4  = group4
                  groupnr = groupnr ).
    else.
      group_hide( group1  = group1
                  group2  = group2
                  group3  = group3
                  group4  = group4
                  groupnr = groupnr ).
    endif.
  endmethod.


  method refresh.
    refresh me->t_screen.
    loop at screen.
      append screen to me->t_screen.
    endloop.
  endmethod.


  method set_cursor.
    v_cursor = fieldname.
  endmethod.


  method set_cursor_field.
    read table t_screen transporting no fields with key name = fieldname.
    if sy-subrc eq 0.
      v_cursor = fieldname.
    else.
      v_cursor = v_field_prefix && fieldname.
    endif.
  endmethod.


  method set_field_atrib.
    field-symbols: <ls_screen> like line of me->t_screen
                   , <lv_atrib> type any.
    .
    data: lv_name(132) type c.
    lv_name = v_field_prefix && fieldname.

    read table me->t_screen with key name = lv_name assigning <ls_screen>.
    if <ls_screen> is not assigned.
      read table me->t_screen with key name = fieldname assigning <ls_screen>.
    endif.
    assign component atrib of structure <ls_screen> to <lv_atrib>.
    <lv_atrib> = value.
  endmethod.


  method set_field_prefix.
    v_field_prefix = field_prefix.
  endmethod.


  method set_group_atrib.
    field-symbols: <ls_screen> like line of me->t_screen
                   , <lv_atrib> type any.

    data(ref_flt) = new zcl_flt( ).

    if group1 is not initial.
      ref_flt->add_value( field = 'GROUP1' low = group1 ).
    endif.
    if group2 is not initial.
      ref_flt->add_value( field = 'GROUP2' low = group2 ).
    endif.
    if group3 is not initial.
      ref_flt->add_value( field = 'GROUP3' low = group3 ).
    endif.
    if group4 is not initial.
      ref_flt->add_value( field = 'GROUP4' low = group4 ).
    endif.
    if groupnr is not initial.
      field-symbols: <group> like group1.
      data(group_name) = 'GROUP' && groupnr.
      ref_flt->add_value( field = 'GROUP' && groupnr low = group1 ).
    endif.

    data(lv_where) = ref_flt->get_where_string( ).
    loop at me->t_screen assigning <ls_screen> where (lv_where).
      assign component atrib of structure <ls_screen> to <lv_atrib>.
      <lv_atrib> = value.
    endloop.
  endmethod.
ENDCLASS.
