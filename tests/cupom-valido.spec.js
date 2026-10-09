import { test, expect } from '@playwright/test';

test('CA01 - Aplicar cupom BEMVINDO10 com 10% de desconto', async ({ page }) => {
  // 1. Acessa a página oficial do ambiente de testes
  await page.goto('https://verzel-store.qa-test-verzel-store.workers.dev/');

  // 2. Adiciona a mochila ao carrinho
  await page.getByRole('article', { name: 'Mochila Urbana 20L' }).getByRole('button', { name: 'adicionar ao carrinho' }).click();

  // 3. Abre o carrinho de compras
  await page.getByRole('link', { name: 'Carrinho 1 itens no carrinho' }).click();

  // 4. Preenche e aplica o cupom de desconto
  await page.getByRole('textbox', { name: 'Cupom de desconto' }).click();
  await page.getByRole('textbox', { name: 'Cupom de desconto' }).fill('BEMVINDO10');
  await page.getByRole('button', { name: 'Aplicar cupom' }).click();

  // 5. Validação indispensável: Garante que o cupom foi aceito pelo sistema
  await expect(page.getByText('Cupom BEMVINDO10 aplicado.')).toBeVisible();
   await expect(page.locator('dl')).toContainText('- R$ 10,00');
  await expect(page.locator('dl')).toContainText('R$ 109,90');
});
