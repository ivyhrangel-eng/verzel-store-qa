import { test, expect } from '@playwright/test';

test('CA05 - Remover cupom e recalcular total', async ({ page }) => {
  await page.goto('https://verzel-store.qa-test-verzel-store.workers.dev/');
  
  // Adiciona o produto ao carrinho
  await page.getByRole('article', { name: 'Mochila Urbana 20L' }).getByRole('button').click();
  await page.getByRole('link', { name: 'Carrinho 1 itens no carrinho' }).click();
  
  // Aplica o cupom de desconto
  await page.getByRole('textbox', { name: 'Cupom de desconto' }).click();
  await page.getByRole('textbox', { name: 'Cupom de desconto' }).fill('bemvindo10');
  await page.getByRole('button', { name: 'Aplicar cupom' }).click();
  
  // Validações do cupom ativo
  await expect(page.locator('dl')).toContainText('- R$ 10,00');
  await expect(page.locator('dl')).toContainText('R$ 109,90');
  
  // Testa a remoção do cupom e retorno dos valores originais
  await page.getByRole('button', { name: 'Remover cupom' }).click();
  await expect(page.locator('dl')).toContainText('R$ 0,00');
  await expect(page.locator('dl')).toContainText('R$ 119,90');
});
