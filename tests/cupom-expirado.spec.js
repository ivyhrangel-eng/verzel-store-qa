import { test, expect } from '@playwright/test';

test('CA04 — Cupom expirado', async ({ page }) => {
  await page.goto('https://verzel-store.qa-test-verzel-store.workers.dev/');
  
  // Adiciona a Jaqueta Corta-Vento ao carrinho
  await page.getByRole('article', { name: 'Jaqueta Corta-Vento' }).getByRole('button').click();
  await page.getByRole('link', { name: 'Carrinho 1 itens no carrinho' }).click();
  
  // Aplica o cupom expirado
  await page.getByRole('textbox', { name: 'Cupom de desconto' }).click();
  await page.getByRole('textbox', { name: 'Cupom de desconto' }).fill('verao2026');
  await page.getByRole('button', { name: 'Aplicar cupom' }).click();
  
  // Validações diretas e robustas
  await expect(page.locator('form')).toContainText('Cupom expirado.');
  await expect(page.locator('dl')).toContainText('DescontoR$ 0,00');
  await expect(page.locator('dl')).toContainText('TotalR$ 229,90');
});
