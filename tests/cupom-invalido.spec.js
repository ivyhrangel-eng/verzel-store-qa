import { test, expect } from '@playwright/test';

test('CA03 — Cupom inválido.', async ({ page }) => {
  // CORREÇÃO: Acessar a URL correta da Verzel Store
  await page.goto('https://verzel-store.qa-test-verzel-store.workers.dev/');
  
  // Adiciona o Tênis Casual Urbano ao carrinho e acessa a tela de checkout
  await page.getByRole('article', { name: 'Tênis Casual Urbano' }).getByRole('button').click();
  await page.getByRole('link', { name: 'Carrinho 1 itens no carrinho' }).click();
  
  // Tenta aplicar um cupom que não existe
  await page.getByRole('textbox', { name: 'Cupom de desconto' }).click();
  await page.getByRole('textbox', { name: 'Cupom de desconto' }).fill('verao15');
  await page.getByRole('button', { name: 'Aplicar cupom' }).click();
  
  // Validações cirúrgicas e robustas
  await expect(page.locator('#mensagem-cupom')).toContainText('Cupom inválido.');
  await expect(page.locator('dl')).toContainText('DescontoR$ 0,00');
  await expect(page.locator('dl')).toContainText('TotalR$ 209,80'); 
});

