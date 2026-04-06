/*Replace accented Portuguese characters with standard characters for data consistency*/
CREATE OR REPLACE FUNCTION stage.clean_accents(input_string STRING)
RETURNS STRING
AS
$$
    TRANSLATE(input_string, 'ÁÀÂÃÉÈÊÍÌÎÓÒÔÕÚÙÛÇ', 'AAAAEEEIIIOOOOUUUC')
$$;
