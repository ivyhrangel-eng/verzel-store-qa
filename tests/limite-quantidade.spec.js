import { test, expect } from '@playwright/test';

test('Validar limite de quantidade e botão desabilitado', async ({ page }) => {
  await page.goto('https://verzel-store.qa-test-verzel-store.workers.dev/');
  
  // 1. Adiciona a mochila e acessa o carrinho
  await page.getByRole('article', { name: 'Mochila Urbana 20L' }).getByRole('button').click();
  await page.getByRole('link', { name: 'Carrinho 1 itens no carrinho' }).click();
  
  // 2. Clica no botão + quatro vezes para atingir o limite de 5 unidades no total
  const botaoAumentar = page.getByRole('button', { name: 'Aumentar quantidade de' });
  await botaoAumentar.click();
  await botaoAumentar.click();
  await botaoAumentar.click();
  await botaoAumentar.click();
  
  // 3. Validações indispensáveis do limite de estoque
  await expect(page.getByRole('listitem')).toContainText('Limite de 5 unidades por produto.');
  await expect(botaoAumentar).toBeDisabled(); // Valida se o botão ficou cinza/bloqueado
});
