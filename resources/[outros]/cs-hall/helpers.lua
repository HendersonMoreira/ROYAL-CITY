-- ===========================================
-- CS-HALL HELPERS - VERSÃO REFATORADA
-- ===========================================

-- ===========================================
-- FUNÇÕES DE STRING
-- ===========================================

-- Verificar se string começa com determinado prefixo
function StartsWith(str, prefix)
    return string.sub(str, 1, string.len(prefix)) == prefix
end

-- ===========================================
-- FUNÇÕES DE TABELA
-- ===========================================

-- Copiar tabela recursivamente
function Copy(originalTable)
    local copy = {}
    
    for key, value in pairs(originalTable) do
        if type(value) == "table" then
            copy[key] = Copy(value)
        else
            copy[key] = value
        end
    end
    
    return copy
end

-- Copiar e mesclar duas tabelas
function CopyAndMerge(baseTable, overrideTable)
    local result = Copy(baseTable)
    
    for key, value in pairs(overrideTable) do
        if type(value) == "table" then
            result[key] = Copy(value)
        else
            result[key] = value
        end
    end
    
    return result
end

-- ===========================================
-- FUNÇÕES MATEMÁTICAS
-- ===========================================

-- Arredondar número para N casas decimais
function Round(number, decimalPlaces)
    local multiplier = 10 ^ (decimalPlaces or 0)
    return math.floor(number * multiplier + 0.5) / multiplier
end

-- ===========================================
-- FUNÇÕES DE ARRAY
-- ===========================================

-- Verificar se valor existe em array
function InArray(value, array)
    for i = 1, #array do
        if value == array[i] then
            return true
        end
    end
    return false
end

-- ===========================================
-- FUNÇÕES DE CONTROLE DE FLUXO
-- ===========================================

-- Operador ternário personalizado
function Ternary(condition, trueValue, falseValue)
    if type(falseValue) == "nil" then
        if type(condition) ~= "nil" then
            if type(condition) ~= "boolean" or condition then
                return condition
            end
        end
        return trueValue
    else
        if type(condition) ~= "nil" then
            if type(condition) ~= "boolean" or condition then
                return trueValue
            end
        end
        return falseValue
    end
end

-- ===========================================
-- FUNÇÕES DE CONVERSÃO
-- ===========================================

-- Converter array de strings para números float
function FloatValues(stringArray)
    local floatArray = {}
    
    for i = 1, #stringArray do
        table.insert(floatArray, tonumber(stringArray[i]) + 0.0)
    end
    
    return floatArray
end
