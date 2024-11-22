CREATE TABLE log_insercoes (
    id SERIAL PRIMARY KEY,
    mensagem TEXT,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION funcao_log_insercoes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_insercoes (mensagem)
    VALUES (FORMAT('Uma nova música foi adicionada: %s', NEW.nome));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_insercoes
AFTER INSERT ON musicas
FOR EACH ROW
EXECUTE FUNCTION funcao_log_insercoes();

INSERT INTO musicas (nome, duracao_seg, artista)
VALUES ('bad ideia', 150, 2);

SELECT * FROM log_insercoes;