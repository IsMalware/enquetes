# HTTP

> ## Casos de sucesso
  1. ✅ Request com o verbo http válido (post)
  2. ✅ Passar nos headers o content type JSON
  3. ✅ Chamar request com body correto
  4. OK - 200 e resposta com dados
  5. No content - 204 e resposta sem dados

> ## Erros
  1. Bad Request - 400
  2. Unauthorized - 401
  3. Forbidden - 403
  4. Not Found - 404
  5. Internal Server Error - 500

> ## Exceção - Status code diferente dos acima
  1. Internal Server Error - 500

> ## Exceção - Http request deu uma Exception
  1. Internal Server Error - 500

> ## Exceção - Verbo http inválido
  1. Internal Server Error - 500