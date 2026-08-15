# zcl_scr — Manejo del Screen

Utilería para modificar dinámicamente los atributos de los campos de pantalla (dynpros y pantallas de selección) sin escribir cada vez el clásico `LOOP AT SCREEN ... MODIFY SCREEN`. Toma una **foto de la tabla `SCREEN`**, se le aplican cambios por campo o por grupo de modificación con métodos legibles, y al final `apply_changes( )` vuelca todo a la pantalla.

```abap
data: ref_scr type ref to zcl_scr.

at selection-screen output.
  ref_scr = new zcl_scr( ).                " captura la tabla SCREEN actual
  ref_scr->field_input_off( 'P_BUKRS' ).   " campo de solo lectura
  ref_scr->field_required_on( 'P_MATNR' ).
  ref_scr->group_hide( group1 = 'AV2' ).   " oculta todo el grupo de modificación
  ref_scr->set_cursor_field( 'P_MATNR' ).
  ref_scr->apply_changes( ).               " LOOP AT SCREEN + MODIFY SCREEN + SET CURSOR
```

## Instalación

Importar con [abapGit](https://abapgit.org). Requiere ABAP 7.40 o superior.

**Dependencia**: requiere el paquete [`zcl_flt`](https://github.com/ricardopsj/zcl_flt) (los métodos `group_*` filtran la tabla `SCREEN` con un WHERE dinámico construido con `zcl_flt`). Importar `zcl_flt` primero.

## Uso

La instancia debe crearse (o llamarse `refresh( )`) **dentro del evento de salida de pantalla** — `AT SELECTION-SCREEN OUTPUT` o un módulo PBO — porque es ahí donde la tabla `SCREEN` está disponible; `apply_changes( )` debe llamarse en ese mismo evento, después de aplicar todos los cambios.

### Por campo

| Método | Atributo SCREEN |
|---|---|
| `field_active( fieldname state )` / `field_active_on` / `field_active_off` | `ACTIVE` (desactivar oculta y deshabilita por completo) |
| `field_input( fieldname state )` / `field_input_on` / `field_input_off` | `INPUT` (editable / solo lectura) |
| `field_required( fieldname state )` / `field_required_on` / `field_required_off` | `REQUIRED` (obligatorio) |
| `field_visible( fieldname state )` / `field_show` / `field_hide` | `INVISIBLE` |
| `set_field_atrib( fieldname atrib value )` | Cualquier atributo de `SCREEN` por nombre (p. ej. `'INTENSIFIED'`) |

`set_field_prefix( )` define un prefijo que se antepone al nombre en todas las búsquedas (p. ej. `'GS_HEAD-'` para pantallas con estructura, o `'P_'` para parámetros con nomenclatura fija); si el nombre con prefijo no existe, se intenta el nombre tal cual.

### Por grupo de modificación

Los mismos verbos, pero aplicados a todos los campos cuyo `GROUP1..GROUP4` coincida (los criterios indicados se combinan con AND):

- `group_active[_on/_off]`, `group_input[_on/_off]`, `group_required[_on/_off]`, `group_visible` / `group_show` / `group_hide`
- `set_group_atrib( ... atrib value )` para cualquier otro atributo.

Cada uno acepta `group1`–`group4` (valor a buscar en esa columna) o `groupnr` (número de columna de grupo).

### Cursor

- `set_cursor_field( fieldname )`: posiciona el cursor (respeta el prefijo configurado).
- `set_cursor( fieldname )`: idem sin resolución de prefijo.

El `SET CURSOR FIELD` se ejecuta dentro de `apply_changes( )`.

### Otros

- `refresh( )`: vuelve a capturar la tabla `SCREEN` (la llama el constructor).
- `t_screen` (público, solo lectura): la foto actual, por si se necesita inspección directa.

## Cómo funciona

Los cambios **no** tocan la pantalla al momento: se aplican sobre la copia interna `t_screen`. `apply_changes( )` recorre la tabla `SCREEN` real y sobrescribe cada línea con la versión modificada de la copia. Esto permite acumular reglas en cualquier orden (incluso decidirlas en métodos separados) y aplicarlas de una sola vez.
