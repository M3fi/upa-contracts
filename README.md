# upa-contracts

Contratos API de Upa! — OpenAPI 3.0.3 y tipos compartidos.

## Estructura

```
contracts/
  openapi/
    m0.openapi.yaml    # Especificación OpenAPI (fuente de verdad)
shared-contract/
  src/
    types.ts           # Tipos TypeScript auto-generados
scripts/
  codegen-dart.sh      # Generador de modelos Dart para la app móvil
```

## Uso

### Generar tipos TypeScript

```bash
npm install
npm run codegen:ts
```

### Generar modelos Dart (requiere openapi-generator)

```bash
npm run codegen:dart
```

### Verificar drift de codegen

```bash
npm run codegen:check
```

## Consumidores

- **upa-backend**: Implementa este contrato
- **upa-frontend**: Importa `shared-contract` como dependencia
- **upa-mobile**: Recibe modelos Dart generados por `codegen-dart.sh`
